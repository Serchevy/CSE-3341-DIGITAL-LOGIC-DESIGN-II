module MODES
(
	input KEY2, 
	output MODE
);

	logic [1:0] state, nextstate;
	
	// MODE_1 16-bit counter
	// MODE_2 Crawling Numbers
	// MODE_3 Crawling Message
	
	parameter MODE_1 = 2'b00, MODE_2 = 2'b01, MODE_3 = 2'b11;
	
	always @ (negedge KEY2)
			state <= nextstate;
			
	always @ (state)
		case(state)
			MODE_1: nextstate = MODE_2;	
			MODE_2: nextstate = MODE_3;
			MODE_3: nextstate = MODE_1;
		endcase

	assign MODE = state;
	
endmodule 