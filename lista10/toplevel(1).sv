module memory(
input wr, clk,
  input [9:0] addr,
  input signed [15:0] in,
  output signed [15:0] out
);
  logic signed [15:0] mem [0:1023];
  assign out = mem[addr-2];
always_ff @(posedge clk)
  if (wr && addr>=0 ) 
    mem[addr] <= in;
endmodule

module reg16(   //szczyt
output logic signed[15:0] q,
input signed [15:0] d,
input clk, nrst
);
always_ff @(posedge clk, negedge nrst)
if (!nrst) q <= 0;
  else  q <= d;
endmodule


module reg10( //cnt
  output logic [9:0] q,
input clk, nrst,push,pop
);
always_ff @(posedge clk, negedge nrst)
if (!nrst) q <= 0;
  else if (push && q<=1023) q <= q+1;
  else if(pop && q>=1) q <= q-1;
endmodule
  

module arith(output signed [15:0] o,input [1:0] op, input signed [15:0] x, y); //operacje +*-

assign o = (op==1)? -x : (op==2)? x+y : (op==3)?  x*y : x;
  
endmodule
 
    
module onp(input nrst,step,push, input signed  [15:0] d,input [1:0] op, 
          output signed [15:0] out, output [9:0] cnt);
  logic czy_odjac;
  assign czy_odjac= !push && ((op == 2) || (op == 3));
  logic signed [15:0] tab_out, pom, wyn;
  assign wyn = push? d : pom;
  reg16 glowa(out,wyn,step,nrst);
  reg10 ilosc(cnt,step, nrst,push,czy_odjac);
  arith a(pom,op,out,tab_out);
  memory mem(push, step, cnt,d,tab_out);
  
  
endmodule
