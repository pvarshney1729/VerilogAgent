module TopModule (
  input  logic [3:0] x,
  input  logic [3:0] y,
  output logic [4:0] sum
);

  logic c1, c2, c3, c4;

  // Full adder for bit 0
  assign {c1, sum[0]} = x[0] + y[0] + 1'b0;

  // Full adder for bit 1
  assign {c2, sum[1]} = x[1] + y[1] + c1;

  // Full adder for bit 2
  assign {c3, sum[2]} = x[2] + y[2] + c2;

  // Full adder for bit 3
  assign {c4, sum[3]} = x[3] + y[3] + c3;

  // Final carry-out for overflow
  assign sum[4] = c4;

endmodule