// diplay 0123456789AbcDEF
// And also HELLO 2 YOU 

module CrawlNumbs
(
	input Clock, CLEAR, 
	output logic [15:0] out
);
	logic [15:0] counter = 16'b0;			// Store Numbs or Message
	logic [3:0] scnd_count = 4'b0;		// Second counter
	
	always_ff @(negedge Clock, negedge CLEAR) begin
		if(CLEAR == 1'b0) begin 
			counter <= 16'b0;					
			scnd_count <= 4'b0;
		end else begin 
			counter = counter << 4;				// Shift original counter 4 bits left
			scnd_count = scnd_count + 4'b1;	// Increase second counter
			counter = counter + scnd_count;	// Add counter and second counter 
		end 		
	end
	
	assign out = counter;					// Output value on counter

endmodule 