//sumator 4 bitowy korzystający z sumatora 1 bitowego 
module add_4bit(input [3:0] a, b,input c0, output [3:0] s4, output c1);
  
  function add_1bit(input x,y,cin, output s1,cout);
  		 cout = x&y || x&cin || y&cin;
  		 s1 = x ^ y ^ cin;
  endfunction
  
  logic c01,c02,c03;
  
  assign f1=add_1bit(a[0],b[0],c0,s4[0],c01);
  assign f2=add_1bit(a[1],b[1],c01,s4[1],c02);
  assign f3=add_1bit(a[2],b[2],c02,s4[2],c03);
  assign f4=add_1bit(a[3],b[3],c03,s4[3],c1);
endmodule

// sumator BCD, dodajemy a i b normalnie jak 4 bitowe binarne, potem sparwdzamy czy nie wyszlismy poza 9,
//jesli tak lub mielismy sume z przeniesieniem  to dodajemy do uzyskanej sumy 6 co daje nam nasz wynik oczekiwany (15 to max na 4 bitach) , jesli nie - dodajemy 0

module add_BCD(input [3:0] a,b, input c0, output [3:0] sum_BCD ,output c1);
  logic [3:0] s1,s2;
  logic c01;
  add_4bit a4_x (a,b,c0,s1,c01);
  assign x=s1[3] & s1[1];
  assign y=s1[2]& s1[3];
  assign c1= x || c01 || y;
  assign s2={1'b0,c1,c1,1'b0};
  add_4bit a4_y (s1,s2,0,sum_BCD,c_out);
  
endmodule


module add_2BCD( input [7:0] a,b, output [7:0] sum2);
  logic [3:0] a1,a2,b1,b2;
  assign a1=a[7:4];
  assign a2=a[3:0];
  assign b1=b[7:4];
  assign b2=b[3:0];
  logic c1,c2;
  logic [3:0] s1,s2,s4;
  add_BCD suma_dz(a1,b1,0,s1,c1);
  add_BCD suma_jedn(a2,b2,0,s2,c2);
  
  assign s3={1'b0,1'b0,1'b0, c2};
  add_BCD suma_dz2(s1,s3,0,s4,c4);
  assign {s4,s2} =sum2;
  
endmodule



module dop_do9(input [3:0] i, output [3:0] o);
  assign i[3]=x;
  assign i[2]=y;
  assign i[1]=z;
  assign i[0]=w;
  assign o[3]=!x&!y&!z;
  assign o[2]=!y&z || y&!z;
  assign o[1]=z;
  assign o[0]= !w;
endmodule


module dop_do9_2(input [7:0] a, output [7:0] b);
  logic [3:0] a1,a2,b1,b2;
  assign a1=a[7:4];
  assign a2=a[3:0];
  dop_do9 dz(a1,b1);
  dop_do9 jedn(a2,b2);
  assign {b1,b2}=b;
endmodule

module substract(input [7:0] x, y, output [7:0] z);
  logic [7:0] y2,s,jeden,s3;
    dop_do9_2 dy(y,y2);
    add_2BCD suma(x,y2,s);
  assign jeden ={1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1};
  add_2BCD suma1(s,jeden,s3);
    assign z=s3;
endmodule


module add_sub_BCD(input [7:0] a, b, input sub, output [7:0] o);
  
  logic [7:0] o1,o2;
  substract subs(a,b,o1);
  add_2BCD add(a,b,o2);
  assign o[7]=o1[7]&&sub || o2[7]&&!sub;
  assign o[6]=o1[6]&&sub || o2[6]&&!sub;
  assign o[5]=o1[5]&&sub || o2[5]&&!sub;
  assign o[4]=o1[4]&&sub || o2[4]&&!sub;
  assign o[3]=o1[3]&&sub || o2[3]&&!sub;
  assign o[2]=o1[2]&&sub || o2[2]&&!sub;
  assign o[1]=o1[1]&&sub || o2[1]&&!sub;
  assign o[0]=o1[0]&&sub || o2[0]&&!sub;
endmodule
