module M_U_X 
(
	input [3:0] OP,
	input logic [15:0] X, AddSub_R, Mul_R, Div_R,
	output [15:0] Rout
);
	
	always_comb begin 
		if(OP[0]) Rout = AddSub_R;
		else 
		if(OP[1]) Rout = AddSub_R;
		else 
		if(OP[2]) Rout = Mul_R;
		else 
		if(OP[3]) Rout = Div_R;
		else Rout = X;
	end

endmodule 