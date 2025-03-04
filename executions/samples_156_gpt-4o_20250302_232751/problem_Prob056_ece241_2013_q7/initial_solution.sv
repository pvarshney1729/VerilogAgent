module TopModule (
  input wire clk,    // Clock signal, active on the positive edge
  input wire rst_n,  // Active-low asynchronous reset
  input wire j,      // J input
  input wire k,      // K input
  output reg Q       // Output Q, initialized to a specific state
);

  // Asynchronous reset and synchronous JK flip-flop behavior
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      Q <= 1'b0;  // Asynchronous reset to 0
    end else begin
      case ({j, k})
        2'b00: Q <= Q;       // Retain state
        2'b01: Q <= 1'b0;    // Reset to 0
        2'b10: Q <= 1'b1;    // Set to 1
        2'b11: Q <= ~Q;      // Toggle state
      endcase
    end
  end

endmodule