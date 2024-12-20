
// Too simple for its own module
module ConditionCode
(
	input [7:0] R,
	input Cout, C7,
	output OVR, Neg, Zero
);
	
	assign OVR = C7 ^ Cout;		// XOR C[8] with C[7]
	assign Neg = R[7];			// Signed number, so MSB determines if neg
	
	assign Zero = ~(R[7] | R[6] | R[5] | R[4] | R[3] | R[2] | R[1] | R[0]);

endmodule 