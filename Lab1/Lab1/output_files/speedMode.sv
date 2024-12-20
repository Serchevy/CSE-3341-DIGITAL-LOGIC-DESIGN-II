module speedMode 
(
	input CLK, CLEAR, X,
	output logic [1:0] SPEED
);
	reg [1:0] state, nextstate;

	parameter s1 = 2'b00, s2 = 2'b01, s3 = 2'b11;
	
	always_ff @ (negedge CLK, negedge CLEAR) begin
		if(CLEAR == 1'b0) 
			state <= s1;
		else 
			state <= nextstate;
	end 
	
	always @ (X, state) 
		case(state)
			s1: if(~X) begin nextstate = s1; SPEED = s1; end 
				else begin nextstate = s2; SPEED = s2; end
			s2: if(~X) begin nextstate = s2; SPEED = s2; end 
				else begin nextstate = s3; SPEED = s3; end
			s3: if(~X) begin nextstate = s3; SPEED = s3; end 
				else begin nextstate = s1; SPEED = s1; end
		endcase 
endmodule 