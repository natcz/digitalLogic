module funnel_shifter(input [7:0] a, b, input [3:0] n, output [7:0] o);
  logic [15:0] conc_ab;
  assign conc_ab = {a,b};
  assign o [7:0]  = conc_ab [n+7:n];
 
endmodule

module ar_prawo(input [7:0] i, output [7:0] o);
  assign o={i[7],i[7],i[7],i[7],i[7],i[7],i[7],i[7]};
endmodule

module shifter(input [7:0] i, input [3:0] n, input lr, ar, rot, output [7:0] o);
  logic [7:0] x,s1,s2,s3,s4,s5,s6;
  
  funnel_shifter log_prawo(8'b00000000,i,n,s1);
  funnel_shifter log_lewo(i,8'b00000000,8-n,s2);
  ar_prawo ap(i,x);
  funnel_shifter ar_prawo(x,i,n,s3);
  funnel_shifter ar_lewo(i,8'b00000000,8-n,s4);
  funnel_shifter rotacja_lewo(i,i,8-n,s5);
  funnel_shifter rotacja_prawo(i,i,n,s6);
  
  assign o = rot? (lr? s5:s6) : ( ar? (lr? s4 : s3) : (lr? s2 : s1));
endmodule
