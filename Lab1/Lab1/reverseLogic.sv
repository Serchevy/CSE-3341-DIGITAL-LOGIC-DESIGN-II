// Toggle output every 10 clock cycles

module reverseLogic 
(
  input CLK, CLEAR,
  output logic UP_DOWN
);

  logic [3:0] counter = 4'b0;

  always_ff @(negedge CLK, negedge CLEAR) begin
    if(CLEAR == 1'b0) begin
      counter <= 4'b0;
      UP_DOWN <= 1'b0;
    end else begin
      counter <= counter + 4'b1;

      if(counter == 4'd8) begin	// 9 does one more cylce than require 
        UP_DOWN <= ~UP_DOWN;		// so had to go w 8
        counter <= 4'b0; 
      end
    end
  end

endmodule 