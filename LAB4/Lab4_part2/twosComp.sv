module twosComp #(parameter N = 8) 
(
    input [N-1:0] input_num,
	 input is_product,
    output logic [N-1:0] twosComp
);
    
    always_comb begin 
		if(is_product == 1'b0) begin 
			if(input_num[N-1] == 1) begin    		// if Negative
				twosComp <= (~input_num) + 1'b1;    // Apply 2s Complement
			end 
			else 
				twosComp <= input_num;       			// else, nothing
		end
		else begin 											// If mult product 
			twosComp <= (~input_num) + 1'b1;     	// Apply 2s Complement
		end
    end
    
endmodule 