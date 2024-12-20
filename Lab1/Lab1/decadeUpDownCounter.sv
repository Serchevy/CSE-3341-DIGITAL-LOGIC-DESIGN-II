module decadeUpDownCounter
(
	input CLK, CLEAR, UP,
	output logic [3:0] COUNT
);

	always_ff @ (negedge CLK, negedge CLEAR)
		if(CLEAR == 1'b0) begin 
			COUNT <= 4'b0;	 		
		end else begin
			if(UP == 0) 														
					COUNT <= COUNT + 1'b1;		// if UP increment by 1
			else												
					COUNT <= COUNT - 1'b1;		// else, decrease by 1
		end
endmodule 