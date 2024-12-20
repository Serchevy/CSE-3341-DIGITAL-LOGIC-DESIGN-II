module clk_ladder #(parameter N = 32)
(
	input CLK, 
	output logic [N-1:0] ladder
);
	
	always_ff @(negedge CLK) 
		ladder <= ladder + 1;
	
	//assign clk190 = ladder[17];	// 50MHz/2^n+1
	
endmodule 