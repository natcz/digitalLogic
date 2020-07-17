module tff(output q, nq, input t, clk, nrst);
logic ns, nr, ns1, nr1, j, k;
nand n1(ns, clk, j), n2(nr, clk, k),
n3(q, ns, nq), n4(nq, nr, q, nrst),
n5(ns1, !clk, t, nq), n6(nr1, !clk, t, q),
n7(j, ns1, k), n8(k, nr1, j, nrst);
endmodule


module counter_up_down_2(input clk, nrst, step, down, output [3:0] out);
 
  logic x,y,z,a,b,c,d;
  tff tf1(out[0], b , !step, clk, nrst);
  assign x = !down & out[0] | down & !out[0] | step;
  
  tff tf2(out[1], a , x, clk, nrst);
  assign y = step & down & !out[1] | down & !step & !out[0] & !out[1] | !down & step & out[1] | !down & !step & out[0] & out[1];
 
  tff tf3(out[2], c, y, clk, nrst);
  assign z = down & step & !out[2] & !out[1] | down & !step & !out[2] & !out[1] & !out[0] | !down & step & out[2] & out[1] | !down & !step & out[0] & out[1] & out[2];
  
  tff tf4(out[3], d, z, clk, nrst);

  
endmodule

  
