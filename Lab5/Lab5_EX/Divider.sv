module Divider 
(
	input [15:0] Dividend,
	input [7:0] Divisor,
	output logic [7:0] Quotient,
	output logic [7:0] Remainder,
	input CLOCK,
	input START,
	output logic DONE
);	
	always_comb begin
		if(Dividend[15] == 1) Dend = ~Dividend + 1'b1;				// If Divident is Neg, apply 2's Complement
			else Dend = Dividend;
		if(Divisor[7] == 1) Dsor = ~Divisor + 1'b1;					// If Divisor is Neg, apply 2's Complement
			else Dsor = Divisor; 
		if(Dividend[15] ^ Divisor[7]) Quotient = ~Q_out + 1'b1;  // Based on MSB of Dividend and Divisor
			else Quotient = Q_out;											// Determine whether to apply 2's Complement
	end																			// on quotient 
	
	logic [15:0] Dend;
	logic [7:0] Dsor;

	logic [8:0] alu_out;
	logic alu_cy;
	logic [8:0] mux_out;
	logic [8:0] mux_in;
	logic [8:0] R_out;
	logic [7:0] Q_out;
	logic [7:0] D_out;
	logic Rload;
	logic Qload;
	logic Dload;
	logic Rshift;
	logic Qshift;
	logic AddSub;
	logic Qbit;
	
	assign Remainder = R_out[7:0];
	assign mux_in = {1'b0, Dend[15:8]};
	//assign Quotient = Q_out;
	
	MUX #(9) Mux1 (alu_out, mux_in, mux_out, Qload);
	
	shiftreg #(9) Rreg (mux_out, R_out, CLOCK, Rload, Rshift, Q_out[7]);
	shiftreg #(8) Qreg (Dend[7:0], Q_out, CLOCK, Qload, Qshift, Qbit);
	shiftreg #(8) Dreg (Dsor, D_out, CLOCK, Dload, 1'b0, 1'b0);
	
	alu #(8) AdSb (R_out, D_out, alu_out, AddSub);
	
	D_Control DivCtrl (CLOCK, START, alu_out[8], AddSub, Dload, Rload, Qload, Rshift, Qshift, DONE, Qbit);
	
endmodule 