module GCLA_AddSub
(
	input [7:0] A, B,
	input Add_Sub,			// Eventually... Feature in the works
	output [7:0] R,
	output Cout,
	output C7
);

	//logic C4;
	logic [7:0] g, p;
	logic P3_0, G3_0, C4, P7_4, G7_4;
	
	FourBit_CLA GCLA4_1stStage		// Fisrt Stage/ fisrt 4 bits computed
	(
		.A(A[3:0]), 
		.B({B[3] ^ Add_Sub, B[2] ^ Add_Sub, B[1] ^ Add_Sub, B[0] ^ Add_Sub}),
		.Cin(Add_Sub), 
		.G(g[3:0]), 
		.P(p[3:0]),
		.Sum(R[3:0]),
		//.Cout(C4)
	);
	
	assign P3_0 = p[3] & p[2] & p[1] & p[0];
	assign G3_0 = g[3] | g[2] & p[3] | g[1] & p[3] & p[2] | g[0] & p[3] & p[2] & p[1];
	assign C4	= G3_0 | P3_0 & Add_Sub;
	
	FourBit_CLA GCLA4_2ndStage		// Second Stage/ second 4 bits computed
	(
		.A(A[7:4]), 
		.B({B[7] ^ Add_Sub, B[6] ^ Add_Sub, B[5] ^ Add_Sub, B[4] ^ Add_Sub}),
		.Cin(C4),
		.G(g[7:4]), 
		.P(p[7:4]),
		.Sum(R[7:4]),
		//.Cout(Cout),
		.C7(C7)
	);
	
	assign P7_4 = p[7] & p[6] & p[5] & p[4]; 
	assign G7_4 = g[7] | g[6] & p[7] | g[5] & p[7] & p[6] | g[4] & p[7] & p[6] & p[5];
	assign Cout = G7_4 | P7_4 & C4;		// C8
	
endmodule 