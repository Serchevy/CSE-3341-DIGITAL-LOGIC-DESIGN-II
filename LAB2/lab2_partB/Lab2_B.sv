module Lab2_B
(
	input CLK, ON_OFF, CLEAR, SW3, SW2, SW1, SW0, SW9,
	output [0:6] HEX,
	output [3:0] CAT
);
		
		logic clock_out, clk190, clk4, clk1; 			// Hold slower clocks
		logic [15:0] counter; 								// Hold numbs or message

		
	OnOffToggle toggle										// Start/Stop button
	(
		.OnOff(ON_OFF),
		.IN(CLK), 
		.OUT(clock_out)
	);
		
		logic slowest_clk_possible;
	
	clockLadder Ladder										// Clock ladder based on 50 MHz clock
	(								
		.CLK(clock_out),
		.CLEAR(CLEAR),  
		.clk190(clk190), 										// 190 hz
		.clk3(clk4), 											// 4 Hz 	4X crawling rate
		.clk1(clk1),											// 1 Hz
	);
	
		logic chosen_clock;
	
	speeds diffFreq 											// Based on Switch-input, a clock rate will be regular or 4x faster
	(
		.SW0(SW0),
		.clk4(clk4), 
		.clk1(clk1),
		.SPEED(chosen_clock)
	);
	
	
	CrawlNumbs CralingThings								// Circular Buffer
	(																// Crawling Numbers/Message
		.Clock(chosen_clock), 								// Crawling arte
		.CLEAR(CLEAR), 
		.out(counter)
	);

	
	MUX Mux_decoder											// Multiplexer and decoder module
	(
		.clk190(clk190), 										// Constant Mux Rate
		.CLEAR(CLEAR),
		.MODE(SW9),
		.D0(counter[3:0]), 
		.D1(counter[7:4]), 
		.D2(counter[11:8]), 
		.D3(counter[15:12]),
		.CAT(CAT), 
		.HEX(HEX)
	);
	

endmodule
