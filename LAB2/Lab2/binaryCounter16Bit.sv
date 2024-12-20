module binaryCounter16Bit
(
	input Clock, CLEAR, 
	output logic [15:0] out
);

	logic [15:0] counter = 16'b0;

	always_ff @(negedge Clock, negedge CLEAR) begin
		if(CLEAR == 1'b0) 
			counter <= 16'b0;					// If clear is set, zero out counter
		else begin 
			counter <= counter + 16'b1;	// Else increase 16-bit binary counter by 1
		end 
	end
	
	assign out = counter;					// Output value on counter

endmodule 