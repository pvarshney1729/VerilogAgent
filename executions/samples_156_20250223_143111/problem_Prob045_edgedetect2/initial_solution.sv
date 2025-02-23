module TopModule
(
  input  logic       clk,
  input  logic [7:0] in_,
  output logic [7:0] anyedge
);

  // Sequential logic

  logic [7:0] reg_in;

  always @( posedge clk ) begin
    reg_in <= in_;
  end

  // Combinational logic

  always @(*) begin
    anyedge = reg_in ^ in_;
  end

endmodule