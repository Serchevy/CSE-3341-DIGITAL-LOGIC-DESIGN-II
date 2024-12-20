module Lab2
(
	input CLK, ON_OFF, CLEAR, SW3, SW2, SW1, SW0,
	output [0:6] HEX,
	output [3:0] CAT
);
		
		logic clock_out, clk190, clk25, clk3, clk1, chosen_clock; 	// Hold slower clocks
		logic [15:0] counter; 													// 16-bit binary counter

		
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
		.clk25(clk25), 										// 25 Hz
		.clk3(clk3), 											// 3 Hz
		.clk1(clk1),											// 1 Hz
		.clk_slowest(slowest_clk_possible)				// 130 Hz with noticeable flickering
	);																// Above 130 Hz screen improves

	
	speeds diffFreq 											// Based on Switch-input, a clock rate will be chosen
	(
		.SW3(SW3),
		.SW2(SW2), 
		.SW1(SW1), 
		.SW0(SW0),
		.clk190(clk190), 
		.clk25(clk25), 
		.clk3(clk3), 
		.clk1(clk1),
		.clk_slowest(slowest_clk_possible),
		.SPEED(chosen_clock)
	);
	
	
	binaryCounter16Bit Count								// 16-bit counter Module
	(																
		.Clock(clk1), 
		.CLEAR(CLEAR), 
		.out(counter)
	);

	
	MUX Mux_decoder											// Multiplexer and decoder module
	(
		.clk190(chosen_clock), 								// MUX Rate
		.CLEAR(CLEAR),
		.D0(counter[3:0]), 
		.D1(counter[7:4]), 
		.D2(counter[11:8]), 
		.D3(counter[15:12]),
		.CAT(CAT), 
		.HEX(HEX)
	);

endmodule
