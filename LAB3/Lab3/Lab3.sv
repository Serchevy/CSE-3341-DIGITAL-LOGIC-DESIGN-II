module Lab3 
(
	input CLK, CLEAR, Add_Sub, Out,
	input [7:0] X,
	input inA, inB,
	//input IN
	//input [7:0] Y,
	output logic [7:0] Rout,
	output logic [3:0] CCout,
	output logic [0:6] HEX, 
	output logic [3:0] CAT
);

	logic [7:0] Aout, Bout, R;
	logic Cout, C7, OVR, Neg, Zero, clk190;
	
	NBitRegister regA
	(
		.D(X) , 			
		.CLK(inA) , 
		.CLR(CLEAR), 	
		.Q(Aout) 		
	);
	
	NBitRegister regB
	(
		.D(X) , 			
		.CLK(inB), 
		.CLR(CLEAR), 	
		.Q(Bout) 		
	);

	// Group CLA Adder/Subtractor
	GCLA_AddSub attempt
	(
		.A(Aout), 
		.B(Bout),
		.Add_Sub(Add_Sub),		
		.R(R),
		.Cout(Cout),
		.C7(C7)
	);
	
	// Register R
	NBitRegister regR
	(
		.D(R), 		
		.CLK(Out), 
		.CLR(CLEAR), 	
		.Q(Rout) 		
	);
	

	divideXN #(263158,32) CLK190			// 190 Hz clock		
	(												// 50e6 / 190 = 263158
		.CLK(CLK), 
		.CLEAR(CLEAR),													
		.OUT(clk190)
	);
	
	Controller Mux
	(
		.clk190(clk190), 								
		.CLEAR(CLEAR),
		.MODE(1'b1),
		.D0(Rout[3:0]), 
		.D1(Rout[7:4]),
		.CAT(CAT), 
		.HEX(HEX)
	);
	
	ConditionCode CCLogic
	(
		.R(R),
		.Cout(Cout), 
		.C7(C7),
		.OVR(OVR), 
		.Neg(Neg), 
		.Zero(Zero)
	);
	
	
	// Register CC
	NBitRegister #(3'd4) regCC
	(
		.D({Cout, OVR, Neg, Zero}) , 		
		.CLK(Out), 
		.CLR(CLEAR), 	
		.Q(CCout) 		
	);


endmodule 