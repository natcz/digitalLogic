
module gray_nr(input [31:0] i, output [31:0] o);
  assign o[31] = i[31];
  integer k;
  always_comb begin 
  for(k = 30; k>=0; k = k-1) 
      o[k] = i[k] ^ o[k+1];
  end 

endmodule


