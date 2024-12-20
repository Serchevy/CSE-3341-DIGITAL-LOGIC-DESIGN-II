// diplay 0123456789AbcDEF

module CrawlNumbs
(
	input Clock, CLEAR, 
	output logic [15:0] out
);
	logic [15:0] counter = 16'b0;
	logic [3:0] scnd_count = 4'b0;

	always_ff @(negedge Clock, negedge CLEAR) begin
		if(CLEAR == 1'b0) begin 
			counter <= 16'b0;					
			scnd_count <= 4'b0;
		end else begin 
			counter = counter << 4;
			scnd_count = scnd_count + 4'b1;
			counter = counter + scnd_count;
		end 
	end
	
	assign out = counter;					// Output value on counter

endmodule 