// Need four clocks at different frequencies 
// Four instantiations of divivideXN

module clockLadder 
(
	input CLK, CLEAR,  
	output logic clk190, clk25, clk3, clk1, clk_slowest
);

	divideXN #(263158,32) clock190		// 190 Hz clock		
	(												// 50e6 / 190 = 263158
		.CLK(CLK), 
		.CLEAR(CLEAR),													
		.OUT(clk190)
	);
	
	divideXN #(2000000,32) clock25		// 25 Hz clock	
	(												// 50e6 / 25 = 2000000
		.CLK(CLK), 	
		.CLEAR(CLEAR), 													
		.OUT(clk25)
	);
	
	divideXN #(16666667,32) clock3		// 3 Hz clock
	(												// 50e6 / 3 = 16666667
		.CLK(CLK), 
		.CLEAR(CLEAR),													
		.OUT(clk3)
	);
	
	divideXN #(50000000,32) clock1		// 1 Hz clock = 50000000
	(
		.CLK(CLK), 
		.CLEAR(CLEAR),													
		.OUT(clk1)
	);
													
	divideXN #(384616,32) slowest		   // 130 Hz 
	(												// Slowest with no flickering on HEX disp
		.CLK(CLK), 
		.CLEAR(CLEAR),													
		.OUT(clk_slowest)
	);


endmodule 