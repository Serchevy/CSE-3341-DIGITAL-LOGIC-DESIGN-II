module TermProject 
(
	input CLK, CLR, Enter, Add, Sub, Mul, Div,
	input [3:0] ROW,
	output logic [3:0] COL,
	output logic [0:6] HEX,
	output logic [3:0] CAT,
	output logic OVR, ZERO 
);

	
	logic LdA, LdB, START_MUL, START_DIV;
	logic [3:0] OP;

	CU control_Unit			// Calculator Control Unit
	(
		.CLK(CLK), 
		.CLR(CLR), 
		.Enter(Enter),
		.Add(Add),
		.Sub(Sub),
		.Mul(Mul),
		.Div(Div),
		.LdA(LdA), 
		.LdB(LdB),
		.START_MUL(START_MUL),
		.START_DIV(START_DIV),
		.OP(OP)
	);
		
	logic [15:0] keyPad;
	
	keypad_input Input_Unit	// Caculator Input Unit
	( 
		.clk(CLK),
		.reset(CLR),
		.row(ROW),
		.col(COL),
		.out(keyPad)
	);
	
	AU Arithmetic_Unit		// Calculator Arithmetic Unit
	(
		.CLK(CLK), 
		.CLR(CLR), 
		.LdA(LdA), 
		.LdB(LdB), 
		.START_MUL(START_MUL),
		.START_DIV(START_DIV),
		.X(keyPad),
		.OP(OP),
		.Rout(OUT),
		.OVR(OVR), 
		.ZERO(ZERO)
		
	);
	
	logic [15:0] OUT;
	
	Controller Output_Unit		// Display Inputs and Result
	(
		.CLK(CLK), 								
		.CLEAR(CLR),
		.MODE(1'b1),
		.D0(OUT[3:0]), 
		.D1(OUT[7:4]),
		.D2(OUT[11:8]),
		.D3(OUT[15:12]),
		.CAT(CAT), 
		.HEX(HEX)
	);
	

endmodule 