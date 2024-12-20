module speeds 
(
	input SW3, SW2, SW1, SW0,
	input clk190, clk25, clk4, clk1, clk_slowest,
	output logic SPEED
);

	always_comb
		case ({SW3, SW2, SW1, SW0}) 	
			4'b0001: SPEED = clk4; 		
			default SPEED = clk1;
		endcase
endmodule 