module four2ten
(
	input [3:0] BIN,
	output logic [9:0] OUT
);
	always_comb
		case ({BIN[3:0]})
			4'b0000: {OUT[9:0]} = 10'b0000000001;	
			4'b0001: {OUT[9:0]} = 10'b0000000010;	
			4'b0010: {OUT[9:0]} = 10'b0000000100;	
			4'b0011: {OUT[9:0]} = 10'b0000001000;	
			4'b0100: {OUT[9:0]} = 10'b0000010000;	
			4'b0101: {OUT[9:0]} = 10'b0000100000;	
			4'b0110: {OUT[9:0]} = 10'b0001000000;	
			4'b0111: {OUT[9:0]} = 10'b0010000000;	
			4'b1000: {OUT[9:0]} = 10'b0100000000;	
			4'b1001: {OUT[9:0]} = 10'b1000000000;	
			default: {OUT[9:0]} = 10'b0000000000;
		endcase
endmodule 