module TopModule (
  input logic clk,
  input logic rst_n,  // Added reset signal
  input logic a,
  input logic b,
  output logic q,
  output logic state
);

  logic state_next;

  // Combinational logic for next state and output q
  always @(*) begin
    state_next = (a & b) ^ state;
    q = (b & ~state);
  end

  // Sequential logic for state update
  always @(posedge clk) begin
    if (!rst_n) begin
      state <= 1'b0;  // Reset to initial state
    end else begin
      state <= state_next;
    end
  end

endmodule