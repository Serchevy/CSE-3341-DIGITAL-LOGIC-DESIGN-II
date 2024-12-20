module FourBit_CLA
(
	input [3:0] A, B, 
	input Cin,
	output logic [3:0] G, P, Sum,
	//output logic Cout,
	output logic C7
);

	logic [4:0] C;
	
	assign G = A & B;					// Generate 
	
	assign P = A ^ B;					// Propagate 
		
	always_comb begin
		C[0] = Cin;
		C[1] = G[0] | P[0] & C[0];	
		C[2] = G[1] | P[1] & C[1];
		C[3] = G[2] | P[2] & C[2];
		C[4] = G[3] | P[3] & C[3];
	end
	
	assign Cout = C[4];					// Output Carry
	
	
	assign Sum = A ^ B ^ C;				// Compute Sum
												// C gets truncated!!! Might be an issue
	assign C7 = C[3];
	
endmodule 