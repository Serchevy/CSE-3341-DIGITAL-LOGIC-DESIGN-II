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
	assign mux_in = {1'b0, Dividend[15:8]};
	assign Quotient = Q_out;
	
	MUX #(9) Mux1 (alu_out, mux_in, mux_out, Qload);
	
	shiftreg #(9) Rreg (mux_out, R_out, CLOCK, Rload, Rshift, Q_out[7]);
	shiftreg #(8) Qreg (Dividend[7:0], Q_out, CLOCK, Qload, Qshift, Qbit);
	shiftreg #(8) Dreg (Divisor, D_out, CLOCK, Dload, 1'b0, 1'b0);
	
	alu #(8) AdSb (R_out, D_out, alu_out, AddSub);
	
	D_Control DivCtrl (CLOCK, START, alu_out[8], AddSub, Dload, Rload, Qload, Rshift, Qshift, DONE, Qbit);
	
endmodule 