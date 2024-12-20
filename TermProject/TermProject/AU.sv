module AU 
(
	input CLK, CLR, LdA, LdB, START_MUL, START_DIV,
	input [15:0] X,
	input [3:0] OP,
	output logic [15:0] Rout,
	output logic OVR, ZERO
);

	logic [15:0] AddSub_R, P, Mul_R, Div_R;
	logic [15:0] A;
	logic [7:0] B, Quotient, Remainder;
	logic C7, Cout, Halt, DONE;

	NBitRegister #(16) InputA 
	(
		.D(X),									
		.CLK(~LdA), 
		.CLR(CLR), 									
		.Q(A) 					
	);
	
	NBitRegister #(8) InputB 
	(
		.D(X),									
		.CLK(~LdB), 
		.CLR(CLR), 									
		.Q(B)						
	);
	
	//------------------------------------------//
		GCLA_AddSub Add_Sub
		(
			.A(A[7:0]), 
			.B(B),
			.Add_Sub(OP[1]),		
			.R(AddSub_R),
			.Cout(Cout),
			.C7(C7)
		);
	//------------------------------------------//
		Multiplier Mult
		(
			.Clock(CLK), 
			.Reset(START_MUL), 				
			.Multiplicand(A[7:0]),
			.Multiplier(B),
			.Product(P), 		
			.Halt(Halt)
		);
		
		NBitRegister #(16) regR
		(
			.D(P), 		
			.CLK(~Halt), 
			.CLR(CLR), 	
			.Q(Mul_R) 		
		);
	//------------------------------------------//
	
		Divider DIVIDE
		(
			.Dividend(A),
			.Divisor(B),
			.Quotient(Quotient),
			.Remainder(Remainder),
			.CLOCK(CLK),
			.START(START_DIV),
			.DONE(DONE)
		);
		
		NBitRegister QUOTIENT			// Quotient 
		(
			.D(Quotient), 		
			.CLK(~DONE), 
			.CLR(CLR), 	
			.Q(Div_R[15:8]) 		
		);
		
		NBitRegister REMAINDER			// Remainder
		(
			.D(Remainder), 		
			.CLK(~DONE), 
			.CLR(CLR), 	
			.Q(Div_R[7:0]) 		
		);
	//------------------------------------------//
	
	
	M_U_X MUX 
	(
		.OP(OP),
		.AddSub_R(AddSub_R), 
		.X(X),
		.Mul_R(Mul_R), 
		.Div_R(Div_R),
		.Rout(Rout)
	);
	
	assign OVR = (C7 ^ Cout) && (OP[0] || OP[1]);	
	assign ZERO = !Rout && OP;
	
endmodule 