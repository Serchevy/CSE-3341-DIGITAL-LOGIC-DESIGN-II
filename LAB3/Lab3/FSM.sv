module FSM
(
	input CLK, CLEAR,
	output logic [1:0] SEL,
	output logic [3:0] CAT
);
	logic [1:0] state, nextstate;
	
	always @ (negedge CLK, negedge CLEAR)
		if (CLEAR == 0) state <= 2'b0; else state <= nextstate;
		
		always @ (state)
			case ({state})																	
				2'b00: begin nextstate = 2'b01; SEL = 2'b00; CAT = 4'b1000; end	// 1st digit
				2'b01: begin nextstate = 2'b10; SEL = 2'b01; CAT = 4'b0100; end	// 2nd digit
				default: begin nextstate = 2'b00; SEL = 2'b00; CAT = 4'b000; end  // Don't touch the other digits
			endcase																					// Not needed here			
endmodule 