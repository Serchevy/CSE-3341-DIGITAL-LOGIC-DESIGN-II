module Lab4_part1
(
	input CLK, CLEAR, inA, inB, Out,
	input [7:0] X,
	//input IN
	//input [7:0] Y,
	//output logic [15:0] Product,
	output logic [0:6] HEX, 
	output logic [3:0] CAT
);

	logic [7:0] M, Q;
	logic [15:0] P;
	logic Halt, clk190;

	NBitRegister Multiplicand
	(
		.D(X) , 			
		.CLK(inA) , 
		.CLR(CLEAR), 	
		.Q(M) 		
	);
	
	NBitRegister Multiplier
	(
		.D(X) , 			
		.CLK(inB), 
		.CLR(CLEAR), 	
		.Q(Q) 		
	);

	
	Multiplier Mult
	(
		.Clock(out), 
		.Reset(CLEAR), 				
		.Multiplicand(M),
		.Multiplier(Q),
		.Product(P), 		
		.Halt(Halt)
	);
	
		divideXN #(263158,32) CLK190	// 190 Hz clock		
	(								
		.CLK(CLK), 
		.CLEAR(CLEAR),													
		.OUT(clk190)
	);
	
	Controller Mux
	(
		.clk190(clk190), 								
		.CLEAR(CLEAR),
		.MODE(1'b1),
		.D0(P[3:0]), 
		.D1(P[7:4]),
		.D2(P[11:8]),
		.D3(P[15:12]),
		.CAT(CAT), 
		.HEX(HEX)
	);


endmodule 