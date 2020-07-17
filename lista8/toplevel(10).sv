
module upcount_load(
  output logic [15:0] q,
  input [15:0] i,
input clk, nrst, load
);
always_ff @(posedge clk)
  if(load) q <= i;
  else if (!nrst) q <= 0;
   else  q <= q+1;
endmodule

module reg16(
output logic [15:0] q,
  input [15:0] d,
input clk,load
);
  logic [15:0] i;
  assign i = load ? d : q;
  always_ff @(posedge clk)
    q <= i;
endmodule



module generatorPWM(input clk, input [15:0] d, input [1:0] sel,
                   output [15:0] cmp, cnt, top, output out);
  
  logic a,b,c,rest;

  assign a = sel[0] & ! sel[1];
  assign b = !sel[0] & sel[1];
  assign c = sel[1] & sel[0];

  assign rest = cnt < top;
  
  
  upcount_load licz(cnt,d,clk,rest,c);    
  reg16 porown(cmp,d, clk,a);
  reg16 wart_szczyt(top, d , clk,b);

  assign out = cnt < cmp;
  
  
  
  
endmodule