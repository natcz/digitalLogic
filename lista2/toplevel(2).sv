module noglitch(output o, input [3:0] i);
 assign x = i[0];
 assign y = i[1];
 assign z = i[2];
 assign w = i[3];
 assign o = (x & y & ~z) |(x & y & ~w) | (~x & y &w) |(z & ~x & y) | ( x & ~y & w) | ( x & ~y & z) | (~z & w & y) | (~z & w & x) | (z & w & ~x) | (z & w & ~y) | (z & ~w & y) | (z & ~w & x);
endmodule
