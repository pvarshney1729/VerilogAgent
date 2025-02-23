module TopModule
(
  input  logic       clk,
  input  logic [7:0] in_,
  output logic [7:0] pedge
);

  // Sequential logic

  logic [7:0] reg_in_;

  always @( posedge clk ) begin
    reg_in_ <= in_;
  end

  // Combinational logic

  always @(*) begin
    pedge = (in_ & ~reg_in_);
  end

endmodule