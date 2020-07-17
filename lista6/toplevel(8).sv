
//napisane z pomocą filmu https://www.youtube.com/watch?v=4UIIBCVU3gY&fbclid=IwAR0qyd1VKpln8CJaRiDF36qul5aEPUxGM9d5EE2OihbqW68cbpFf-msbInc

module d_latch(output q, nq, input en, d);
logic nr, ns;
nand gq(q, nr, nq), gnq(nq, ns, q),
gr(nr, d, en), gs(ns, nr, en);
endmodule

module dff_ms(output q, nq, input clk, d);
logic q1;
d_latch dl1(q1, , !clk, d), dl2(q, nq, clk, q1);
endmodule



module mux_4(output o, input a,b,c,d, input x,y);
 logic x1,x2,x3,x4;
  assign x1 = a & !x & !y;
  assign x2 = b & !x & y;
  assign x3 = c & x & !y;
  assign x4 = d & x & y;
  assign o = x1 | x2 | x3 | x4;
endmodule
  
module univ_shifter_reg(output [7:0] q,input [7:0] d, input i,c,l,r);
  
  logic o1,o2,o3,o4,o5,o6,o7,o8;
  logic x1,x2,x3,x4,x5,x6,x7,x8;
  

  
  mux_4 m1( o1, q[0],q[1], i,  d[0],r,l);
  mux_4 m2( o2, q[1],q[2],q[0],d[1],r,l);
  mux_4 m3( o3, q[2],q[3],q[1],d[2],r,l);
  mux_4 m4( o4, q[3],q[4],q[2],d[3],r,l);
  mux_4 m5( o5, q[4],q[5],q[3],d[4],r,l);
  mux_4 m6( o6, q[5],q[6],q[4],d[5],r,l);
  mux_4 m7( o7, q[6],q[7],q[5],d[6],r,l);
  mux_4 m8( o8, q[7],i,   q[6],d[7],r,l);
  
  dff_ms d1( q[0],x1, c, o1);
  dff_ms d2( q[1],x2 , c, o2);
  dff_ms d3( q[2],x3 , c, o3);
  dff_ms d4( q[3],x4 , c, o4);
  dff_ms d5( q[4],x5 , c, o5);
  dff_ms d6( q[5],x6 , c, o6);
  dff_ms d7( q[6],x7, c, o7);
  dff_ms d8( q[7],x8 , c, o8);
  
 

  
  
endmodule

  
  

