module CU 
(
	input CLK, CLR, Enter, Add, Sub, Mul, Div,
	output logic LdA, LdB, START_MUL, START_DIV,
	output logic [3:0] OP
);
	
	logic [2:0] state, nextstate;
	parameter WAIT = 3'b000, LoadA = 3'b001, LoadB = 3'b011, ADD = 3'b010, SUB = 3'b100, MUL = 3'b101, DIV = 3'b111;
	
	logic [31:0] ladder;
	logic EnterSync;
	
	
	clk_ladder slowerCLK
	(
		.CLK(CLK), 
		.ladder(ladder)
	);
	
	EdgeDetect detect
	( 
		.in(Enter), 
		.clock(ladder[15]),  // 50MHz/2^(15+1) ~ 763 Hz
		.out(EnterSync)
	);
		
	always @(negedge ladder[15], negedge CLR) begin 
		if (CLR == 0) state <= WAIT;
		else state <= nextstate;
	end
	
	always_comb
		case ({state})
			WAIT: 	begin 
							if(EnterSync == 1'b1) nextstate <= LoadA; 
							else nextstate <= WAIT;
															LdA <= 1'b0; LdB <= 1'b0; OP <= 4'b0000; START_MUL <= 1'b0; START_DIV <= 1'b0; end 
			LoadA: 	begin 
							if(EnterSync == 1'b1) nextstate <= LoadB; 
							else nextstate <= LoadA;
															LdA <= 1'b1; LdB <= 1'b0; OP <= 4'b0000; START_MUL <= 1'b0; START_DIV <= 1'b0; end 
			LoadB: 	begin 
							if(Add == 0) 		nextstate <= ADD;
							else if(Sub == 0) nextstate <= SUB;
							else if(Mul == 0) nextstate <= MUL;
							else if(Div == 0) nextstate <= DIV;	
							else 					nextstate <= LoadB; 	
															LdA <= 1'b0; LdB <= 1'b1; OP <= 4'b0000; START_MUL <= 1'b0; START_DIV <= 1'b0; end 
			ADD:		begin nextstate <= ADD; 	LdA <= 1'b0; LdB <= 1'b0; OP <= 4'b0001; START_MUL <= 1'b0; START_DIV <= 1'b0; end
			SUB: 		begin nextstate <= SUB; 	LdA <= 1'b0; LdB <= 1'b0; OP <= 4'b0010; START_MUL <= 1'b0; START_DIV <= 1'b0; end
			MUL:		begin nextstate <= MUL; 	LdA <= 1'b0; LdB <= 1'b0; OP <= 4'b0100; START_MUL <= 1'b1; START_DIV <= 1'b0; end
			DIV: 		begin nextstate <= DIV; 	LdA <= 1'b0; LdB <= 1'b0; OP <= 4'b1000; START_MUL <= 1'b0; START_DIV <= 1'b1; end
			default: begin nextstate <= WAIT;	LdA <= 1'b0; LdB <= 1'b0; OP <= 4'b0000; START_MUL <= 1'b0; START_DIV <= 1'b0; end 
		endcase
		
endmodule 
