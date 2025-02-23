module TopModule
(
  input  logic       clk,
  input  logic       reset,
  input  logic [31:0] in_,
  output logic [31:0] out
);

  // Sequential logic

  logic [31:0] reg_in;
  logic [31:0] reg_out;

  always @( posedge clk ) begin
    if ( reset )
      reg_out <= 0;
    else
      reg_out <= (reg_in & ~in_) | reg_out;
    reg_in <= in_;
  end

  // Structural connections

  assign out = reg_out;

endmodule