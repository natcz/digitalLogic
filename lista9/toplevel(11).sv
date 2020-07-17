
module mikrowave(input clk, nrst, door, start, finish,
                 output heat, light, bell);
  // kody stanów automatu
  const logic [2:0] closed = 3'b000, cook = 3'b001,
					pause = 3'b010, bell1 = 3'b011, open = 3'b100;
// stan automatu
  logic [2:0] q;
  logic l;
  
  always_comb begin
   heat = 0; light = 0; bell=0;
    unique case (q)
      closed: begin heat = 0; light = 0; bell = 0; end
      cook: begin heat = 1; light = 1; bell = 0; end
      pause: begin heat = 0; light = 1; bell = 0; end
      bell1: begin heat = 0; light = 0; bell = 1; end
      open: begin heat = 0; light = 1; bell = 0; end
  endcase
	end
  
  always_comb unique case (q)
    closed: l = start && !door || door;
   	cook:  l = door || finish && !door;
    pause: l = !door;
    bell1: l = door;
    open: l = !door;
    default: l = 3'bx;
	endcase
  
  always_ff @(posedge clk or negedge nrst)
    if (!nrst) q <= closed;
 	else if (l) unique case(q)
      closed: begin if (door) q <= open; else q <= cook; end  
      cook: begin if(door) q <=  pause; else  q <= bell1; end  
      pause: begin  q <= cook; end  
      bell1: begin  q <= open;  end 
      open: begin  q <= closed; end      
  endcase
endmodule

  

