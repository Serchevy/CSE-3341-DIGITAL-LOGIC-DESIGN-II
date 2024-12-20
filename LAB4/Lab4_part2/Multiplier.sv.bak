//Multiplier. Verilog behavioral model.
module Multiplier
(
	input Clock, Reset, 				//declare inputs
	input [7:0] Multiplicand,
	input [7:0] Multiplier,
	output logic [15:0] Product,	//declare outputs
	output logic Halt
);
	logic [7:0] RegQ, RegM; 		// Q and M registers
	logic [8:0] RegA; 				// A register
	logic [2:0] Count; 				// 3-bit iteration counter
	
	logic C0, Start, Add, Shift;
	assign Product = {RegA[7:0],RegQ}; 				//product = A:Q
	
	// 2-bit counter for #iterations
	always_ff @(negedge Clock)
		if (Start == 1) Count <= 3'b000; 		  	// clear in Start state
		else if (Shift == 1) Count <= Count + 1; 	// increment in Shift state
	
	assign C0 = Count[2] & Count[1] & Count[0]; 				// detect count = 7
	
	// Multiplicand register (load only)
	always_ff @(negedge Clock)
		if (Start == 1) RegM <= Multiplicand; 		// load in Start state
	
	// Multiplier register (load, shift)
	always_ff @(negedge Clock)
		if (Start == 1) RegQ <= Multiplier; 					// load in Start state
		else if (Shift == 1) RegQ <= {RegA[0],RegQ[7:1]}; 	// shift in Shift state
		
	// Accumulator register (clear, load, shift)
	always_ff @(negedge Clock)
		if (Start == 1) RegA <= 9'b0; 				// clear in Start state
		else if (Add == 1) RegA <= RegA + RegM; 	// load in Add state
		else if (Shift == 1) RegA <= RegA >> 1; 	// shift in Shift state

	// Instantiate controller module
	MultControl Ctrl (Clock, Reset, RegQ[0], C0, Start, Add, Shift, Halt);

endmodule 