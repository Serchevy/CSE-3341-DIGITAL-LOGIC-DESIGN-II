module four2one 
(
	input [1:0] A,
	input [3:0] D0, D1, D2, D3,
	output logic [3:0] OUTPUT
);
	
	always_comb
		case({A})
			2'b00: OUTPUT = D0;	// 1st digit
			2'b01: OUTPUT = D1;	// 2nd digit
			2'b10: OUTPUT = D2; 	// 3rd digit
			2'b11: OUTPUT = D3; 	// 4th digit
		endcase
		
endmodule 