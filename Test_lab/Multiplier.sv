//Multiplier. Verilog behavioral model.
module Multiplier (
input Clock, Reset, //declare inputs
input [3:0] Multiplicand,
input [3:0] Multiplier,
output [7:0] Product, //declare outputs
output Halt
);
reg [3:0] RegQ, RegM; // Q and M registers
reg [4:0] RegA; // A register
reg [1:0] Count; //2-bit iteration counter
wire C0, Start, Add, Shift;
assign Product = {RegA[3:0],RegQ}; //product = A:Q
// 2-bit counter for #iterations
always @(posedge Clock)
if (Start == 1) Count <= 2'b00; // clear in Start state
else if (Shift == 1) Count <= Count + 1; // increment in Shift state
assign C0 = Count[1] & Count[0]; // detect count = 3
// Multiplicand register (load only)
always @(posedge Clock)
if (Start == 1) RegM <= Multiplicand; // load in Start state
// Multiplier register (load, shift)
always @(posedge Clock)
if (Start == 1) RegQ <= Multiplier; // load in Start state
else if (Shift == 1) RegQ <= {RegA[0],RegQ[3:1]}; // shift in Shift state
// Accumulator register (clear, load, shift)
always @(posedge Clock)
if (Start == 1) RegA <= 5'b00000; // clear in Start state
else if (Add == 1) RegA <= RegA + RegM; // load in Add state
else if (Shift == 1) RegA <= RegA >> 1; // shift in Shift state
// Instantiate controller module
MultControl Ctrl (Clock, Reset, RegQ[0], C0, Start, Add, Shift, Halt);
endmodule
