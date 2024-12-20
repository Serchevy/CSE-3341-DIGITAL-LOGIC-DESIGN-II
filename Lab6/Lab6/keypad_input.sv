module keypad_input #( parameter DIGITS = 4)
( 
	input clk,
	input reset,
	input [3:0] row,
	input BASE,
	output [3:0] col,
	output [(DIGITS*4)-1:0] out,
	// Debug
	output logic [3:0] value,
	output logic trig
);
	keypad_base keypad_base
	(
		.clk(clk),
		.row(row),
		.BASE(BASE),
		.col(col),
		.value(value),
		.valid(trig)
	);
	
	shift_reg #(.COUNT(DIGITS)) shift_reg
	(
		.trig(trig),
		.in(value),
		.out(out),
		.reset(reset)
	);

endmodule
