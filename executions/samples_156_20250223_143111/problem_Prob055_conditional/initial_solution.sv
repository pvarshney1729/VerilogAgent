module TopModule
(
  input  logic [7:0] a,
  input  logic [7:0] b,
  input  logic [7:0] c,
  input  logic [7:0] d,
  output logic [7:0] min
);

  // Combinational logic

  always @(*) begin
    min = a;
    if (b < min) min = b;
    if (c < min) min = c;
    if (d < min) min = d;
  end

endmodule