module shifter_right(input [3:0] i,input r, output [3:0] o);
  assign o[3]=1'b0 && r;
  assign o[2]=i[3] && r;
  assign o[1]=i[2] && r;
  assign o[0]=i[1] && r;
endmodule

module shifter_left(input [3:0] i,input l, output [3:0] o);
  assign o[3]=i[2] && l;
  assign o[2]=i[1] && l;
  assign o[1]=i[0] && l;
  assign o[0]=1'b0 && l;
endmodule

module or_4bit(input [3:0] i,j, output [3:0] o);
    assign o[3]=i[3] || j[3];
    assign o[2]=i[2] || j[2];
    assign o[1]=i[1] || j[1];
    assign o[0]=i[0] || j[0];
endmodule 

module no_change(input [3:0]i, input x, output [3:0] o);
  assign o[3]=i[3] && x;
  assign o[2]=i[2] && x;
  assign o[1]=i[1] && x;
  assign o[0]=i[0] && x;
endmodule


module shifter_4bit(input [3:0]i, input l,r, output [3:0] o);
  logic [3:0] x,y,z;
  logic c,notc;
  logic [3:0] l_or_r, change_or_not;
  assign c = l || r;
  assign notc = !c;
  


  shifter_right right(i,r,x);
  shifter_left  left(i,l,y);
  no_change  nchange(i,notc,z);
  
  or_4bit lr(x,y,l_or_r);
  or_4bit cn(l_or_r,z,change_or_not);
  
  assign o[3]=change_or_not[3];
  assign o[2]=change_or_not[2];
  assign o[1]=change_or_not[1];
  assign o[0]=change_or_not[0];
  
endmodule
