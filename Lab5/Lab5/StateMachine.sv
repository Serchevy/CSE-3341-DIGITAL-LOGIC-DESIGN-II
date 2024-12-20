module StateMachine
(
	input CLK, CLEAR,
	input [7:0] B,
	input [15:0] A, Q_R,
	output logic [15:0] display,
	output logic [3:0] ins
);
	logic [2:0] state, nextstate;
	
	always @ (negedge CLK, negedge CLEAR)
		if (CLEAR == 0) state <= 3'b0;
		else state <= nextstate;
		
		always @ (state)
			case ({state})	
				3'b000: begin nextstate = 3'b001; display = 16'b0; ins = 4'b0000; end
				3'b001: begin nextstate = 3'b010; display = A; 		ins = 4'b0001; end
				3'b010: begin nextstate = 3'b011; display = A; 		ins = 4'b0010; end	
				3'b011: begin nextstate = 3'b100; display = B; 		ins = 4'b0100; end	
				3'b100: begin nextstate = 3'b100; display = Q_R; 	ins = 4'b1000; end
			endcase
endmodule 