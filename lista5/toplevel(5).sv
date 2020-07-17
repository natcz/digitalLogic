module min(input [3:0] a,b, output[3:0] o,u);
  assign o = a<=b?  a : b;
  assign u = a<b?  b : a;
endmodule 

module sort(input [15:0] i, output [15:0] o);
  logic [3:0] a,b,c,d;
  assign a = i[3:0];
  assign b = i[7:4];
  assign c = i[11:8];
  assign d = i[15:12];
  
  logic [3:0] min1, max1,min2,max2, min0, max3, max0, min3, min01,min02;
  //max0,min0 - max z calosci min z calosci
  //kolejnosc bedzie taka: max0,min01,min02,min0
  
  min m1(a,b,min1,max1);
  min m2(c,d,min2,max2);
  min m3(min1, min2, min0, max3);
  min m4(max1, max2, min3, max0);
  min m5(min3, max3, min02, min01);
  
  assign o[3:0]=min0;
  assign o[7:4]=min02;
  assign o[11:8]=min01;
  assign o[15:12]=max0;
  
endmodule
