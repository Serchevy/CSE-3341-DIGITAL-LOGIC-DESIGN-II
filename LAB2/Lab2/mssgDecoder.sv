module mssgDecoder 
(
	input [3:0] BIN, 
	output logic [0:6] SEV
); 

	always_comb 
		case ({BIN[3:0]}) 		  //ABCDEFG
			4'b0000: {SEV[0:6]} = 7'b0000000; 
			4'b0001: {SEV[0:6]} = 7'b0110111;	// H 
			4'b0010: {SEV[0:6]} = 7'b1001111;	// E
			4'b0011: {SEV[0:6]} = 7'b0001110;	// L 
			4'b0100: {SEV[0:6]} = 7'b0001110;	// L 
			4'b0101: {SEV[0:6]} = 7'b1111110;	// O
			4'b0110: {SEV[0:6]} = 7'b0000000;	// 
			4'b0111: {SEV[0:6]} = 7'b1101101;	// 2
			4'b1000: {SEV[0:6]} = 7'b0000000;	// 
			4'b1001: {SEV[0:6]} = 7'b0110011;	// Y 
			4'b1010: {SEV[0:6]} = 7'b1111110;	// O
			4'b1011: {SEV[0:6]} = 7'b0111110;	// U
			default: {SEV[0:6]} = 7'b0000000;
		endcase
		
endmodule  