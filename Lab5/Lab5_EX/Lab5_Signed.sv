module Lab5_Signed
(
	input CLK, CLR, LOAD_NEXT,
	input [7:0] X,
	output logic [0:6] HEX,
	output logic [3:0] CAT,
	input S
);
	logic [15:0] A;	// Dividend
	logic [7:0] B;		// Divisor
	
	logic [7:0] Quotient;
	logic [7:0] Remainder;
	logic [15:0] Quo_Rem, OUT;
	logic [3:0] load_val;
	logic DONE;
	
	StateMachine A_B_Q_R_Display	// Chose value to Display
	(										// 
		.CLK(LOAD_NEXT),				// Dividend
		.CLEAR(CLR),					// Divisor 
		.A(A),							// Quotient, Remainder
		.B(B), 
		.Q_R(Quo_Rem),
		.display(OUT),
		.ins(load_val)
	);
	
	NBitRegister DIVIDEND_2			// Upper Half of Dividend
	(
		.D(X), 			
		.CLK(~load_val[0]), 
		.CLR(CLR), 	
		.Q(A[15:8]) 		
	);
	
	NBitRegister DIVIDEND_1			// Lowr half of Dividend
	(
		.D(X), 			
		.CLK(~load_val[1]), 
		.CLR(CLR), 	
		.Q(A[7:0]) 		
	);

	
	NBitRegister DIVISOR				// Divisor 
	(
		.D(X), 			
		.CLK(~load_val[2]), 
		.CLR(CLR), 	
		.Q(B) 		
	);
	
	Divider DIVIDE
	(
		.Dividend(A),
		.Divisor(B),
		.Quotient(Quotient),
		.Remainder(Remainder),
		.CLOCK(CLK),
		.START(~S),
		.DONE(DONE)
	);
	
	NBitRegister QUOTIENT			// Quotient 
	(
		.D(Quotient), 		
		.CLK(~DONE), 
		.CLR(CLR), 	
		.Q(Quo_Rem[15:8]) 		
	);
	
	NBitRegister REMAINDER			// Remainder
	(
		.D(Remainder), 		
		.CLK(~DONE), 
		.CLR(CLR), 	
		.Q(Quo_Rem[7:0]) 		
	);
	
	Controller Mux						// Display Stuff
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