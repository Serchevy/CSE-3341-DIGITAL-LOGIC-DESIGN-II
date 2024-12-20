//Multiplier controller. Verilog behavioral model.
module MultControl (
input Clock, Reset, Q0, C0, //declare inputs
output Start, Add, Shift, Halt); //declare outputs
reg [4:0] state; //five states (one hot – one flip-flop per state)
//one-hot state assignments for five states
parameter StartS=5'b00001, TestS=5'b00010, AddS=5'b00100, ShiftS=5'b01000, HaltS=5'b10000;
reg [1:0] Counter; //2-bit counter for # of algorithm iterations
// State transitions on positive edge of Clock or Resets
always @(posedge Clock, posedge Reset)
if (Reset==1) state <= StartS; //enter StartS state on Reset
else //change state on Clock
case (state)
StartS: state <= TestS; // StartS to TestS
TestS: if (Q0) state <= AddS; // TestS to AddS if Q0=1
else state <= ShiftS; // TestS to ShiftS if Q0=0
AddS: state <= ShiftS; // AddS to ShiftS
ShiftS: if (C0) state <= HaltS; // ShiftS to HaltS if C0=1
else state <= TestS; // ShiftS to TestS if C0=0
HaltS: state <= HaltS; // stay in HaltS
endcase
// Moore model - activate one output per state
assign Start = state[0]; // Start=1 in state StartS, else 0
assign Add = state[2]; // Add=1 in state AddS, else 0
assign Shift = state[3]; // Shift=1 in state ShiftS, else 0
assign Halt = state[4]; // Halt=1 in state HaltS, else 0
endmodule