module speeds 
(
	input SW3, SW2, SW1, SW0,
	input clk190, clk25, clk3, clk1, clk_slowest,
	output logic SPEED
);	

	// clk_slowest --> Shows little flickering on hex dislpay
	
	// Base on which switch is high
	// Chose a clock from clockLadder
	
	always_comb
		case ({SW3, SW2, SW1, SW0}) 	
			4'b0001: SPEED = clk1; 	
			4'b0010: SPEED = clk3;  
			4'b0100: SPEED = clk25;
			4'b1000: SPEED = clk_slowest;	
			default SPEED = clk190;				
		endcase
endmodule 