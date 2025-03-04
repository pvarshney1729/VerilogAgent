module TopModule (
  input logic clk,
  input logic L,
  input logic q_in,
  input logic r_in,
  input logic reset_n,
  output logic Q
);

  always @(posedge clk) begin
    if (!reset_n) begin
      Q <= 1'b0;
    end else if (L) begin
      Q <= r_in;
    end else begin
      Q <= q_in ^ Q;
    end
  end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly