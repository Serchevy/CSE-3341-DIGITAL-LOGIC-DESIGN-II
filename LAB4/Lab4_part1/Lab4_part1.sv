module Lab4_part1
(
	input CLK, CLEAR, inM, inQ, Out,
	input [7:0] X,
//	input [7:0] Min,
//	input IN,
//	input [7:0] Qin,
	output logic [15:0] Pout,
	output logic [0:6] HEX, 
	output logic [3:0] CAT
);

	logic [7:0] M, Q;
	logic [15:0] P;
	logic Halt, clk190;

	NBitRegister Multiplicand
	(
		.D(X) , 			
		.CLK(inM), 
		.CLR(CLEAR), 	
		.Q(M) 		
	);
	
	NBitRegister Multiplier
	(
		.D(X) , 			
		.CLK(inQ), 
		.CLR(CLEAR), 	
		.Q(Q) 		
	);	
	
	Multiplier Mult
	(
		.Clock(CLK), 
		.Reset(Out), 				
		.Multiplicand(M),
		.Multiplier(Q),
		.Product(P), 		
		.Halt(Halt)
	);
	
	NBitRegister #(16) regR
	(
		.D(P), 		
		.CLK(~Halt), 
		.CLR(CLEAR), 	
		.Q(Pout) 		
	);
	
	clk_ladder clock
	(
		.CLK(CLK), 
		.clk190(clk190)
	);
	
	Controller Mux
	(
		.clk190(clk190), 								
		.CLEAR(CLEAR),
		.MODE(1'b1),
		.D0(Pout[3:0]), 
		.D1(Pout[7:4]),
		.D2(Pout[11:8]),
		.D3(Pout[15:12]),
		.CAT(CAT), 
		.HEX(HEX)
	);

endmodule 