module divideXN #(parameter N = 10, parameter M = 4)	
(
	input CLK, CLEAR,
	output logic [M-1:0] COUNT, 							// COUNT is defined as a M-bit register
	output logic OUT
);
	always_ff @ (negedge CLK, negedge CLEAR)
		if (CLEAR == 1'b0) 
			COUNT <= 0; 										// COUNT is loaded with all 0's
		else begin
			if (COUNT == N-2'd2) begin 
				OUT <= 1'b1; 
				COUNT <= N-1'd1; 								// Once COUNT = N-2 OUT = 1
			end else
				if (COUNT == N-1'd1) begin 
					OUT <= 1'b0; 
					COUNT <= 0; 								// Once COUNT = N-1 OUT=0
				end else begin 
					OUT <= 1'b0; 
					COUNT <= COUNT + 1'b1; 					// COUNT is incremented
				end 		
		end
endmodule 