module Controller 
(
	input clk190, CLEAR, MODE,
	input [3:0] D0, D1, D2, D3, 
	output logic [3:0] CAT, 
	output logic [0:6] HEX
);

		logic [1:0] RA;			// Digit in-code
		logic [3:0] out;			// Active Digit on Hex Display

		
	four2one decoder			 	// Four to one module
	(									
		.A(RA),
		.D0(D0), 
		.D1(D1), 
		.D2(D2), 
		.D3(D3),
		.OUTPUT(out)
	);
	
	FSM digit						// Finite State Machine
	(									// Actively updates HEX digit
		.CLK(clk190),
		.CLEAR(CLEAR),
		.SEL(RA),
		.CAT(CAT)
	);

	
	binary2seven Hex				//	Display Numbers
	(									
		.BIN(out), 
		.MODE(MODE),
		.SEV(HEX)
	);
	

endmodule 