module Lab6 
(
	input CLK, CLR, BASE,
	input [3:0] ROW,
	output logic [3:0] COL,
	output logic [0:6] HEX,
	output logic [3:0] CAT
);
	logic [15:0] OUT;

	keypad_input INPUT
	( 
		.clk(CLK),
		.reset(CLR),
		.row(ROW),
		.BASE(BASE),
		.col(COL),
		.out(OUT)
	);
	
	
	Controller Mux		// Display Stuff
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