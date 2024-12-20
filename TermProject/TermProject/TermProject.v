module TermProject (
	input clock, enter, add_sub, clear,
	input [3:0] row,
	output [3:0] col,
	output HEX3, inv,
	output [0:6] HEX2, HEX1, HEX0,
	output [1:0] LED
	);
	
	wire reset, LdA, LdB, LdR, LdOU, IUAU;
	
	CU controlUnit (
		.clock(clock), 
		.enter(enter), 
		.clear(clear),
		.reset(reset), 
		.LdA(LdA), 
		.LdB(LdB), 
		.LdR(LdR),
		.LdOU(LdOU), 
		.IUAU(IUAU),
		.LED(LED)
	);
	
	wire [7:0] x;
	
	Calc_IU IU (
		.clock(clock), 
		.reset(clear), 
		.row(row),
		.col(col),
		.LEDR(x),
		.invalid(inv)
	);
	
	wire [7:0] Rout;
	
	EightBitRegister AU (
		.X(x), 
		.inA(LdA), 
		.inB(LdB), 
		.Add_Sub(add_sub), 
		.Out(LdR), 
		.Clear(clear),
		.Rout(Rout)
	);
	
	reg [7:0] out;
	
	always @(IUAU) begin 
		if(IUAU == 1'b1) 
			out = x;
		else 
			out = Rout; 
	end 
	
	CalculatorOU OU (
		.x(out), 
		.HEX3(HEX3),
		.HEX2(HEX2), 
		.HEX1(HEX1), 
		.HEX0(HEX0)
	);
	
endmodule 