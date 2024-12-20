module Signed 
(
	input [7:0] B, Q, 
	input [15:0] A,  
	output logic [7:0] B_s, Q_s,
	output logic [15:0] A_s 
);
	
	always_comb begin
		if(A[15] == 1) A_s = ~A + 1'b1;
			else A_s = A;
		if(B[7] == 1) B_s = ~B + 1'b1;
			else B_s = B;
		if(A[15] ^ B[7]) Q_s = ~Q + 1'b1;
			else Q_s = Q;
	end
	
//	always_ff @(posedge START, posedge DONE) begin
//		if (START == 1) begin 
//		if(Dividend[15] == 1) Dend = ~Dividend + 1'b1;
//			else Dend = Dividend;
//		if(Divisor[7] == 1) Dsor = ~Divisor + 1'b1;
//			else Dsor = Divisor;
//		end 
//		
//		if(DONE == 1) begin 
//			if(Dividend[15] ^ Divisor[7]) Quotient = ~Q_out + 1'b1;
//				else Quotient = Q_out;
//		end
//	end
	
	
endmodule 