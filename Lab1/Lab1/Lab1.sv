module Lab1
(
	input CLK, ON_OFF, CLEAR, 
	output [9:0] LEDR,
	output [0:6] HEX0
);
	
		logic clock_out;
	
	OnOffToggle toggle 
	(
		.OnOff(ON_OFF),
		.IN(CLK), 
		.OUT(clock_out)
	);
		
		logic slow_clock, up_down;
		logic [3:0] count1, count2;
	
	// 5000000  --> Once every sec
	// 2500000  --> Twice every sec
	// 10000000 --> Once every 2 sec
	
	divideXN #(10000000, 32) divByCntr
	(
		.CLK(clock_out), 
		.CLEAR(CLEAR),
		.COUNT(count1),													
		.OUT(slow_clock)
	);
		
	reverseLogic RvrsLgc
	(
		.CLK(slow_clock),
		.CLEAR(CLEAR),
		.UP_DOWN(up_down)
	);

	decadeUpDownCounter UpDwnCntr
	(
		.CLK(slow_clock), 
		.CLEAR(CLEAR),
		.UP(up_down),
		.COUNT(count2)
	);
	
	four2ten fourDecoder
	(
		.BIN(count2),
		.OUT(LEDR)
	);
	
	binary2seven B2Sev
	(
		.BIN(count2), 
		.SEV(HEX0)
	); 

endmodule
