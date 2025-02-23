module TopModule
(
  input  logic [3:0] x,
  input  logic [3:0] y,
  output logic [4:0] sum
);

  // Full adder logic

  logic c0, c1, c2, c3;

  assign {c0, sum[0]} = x[0] + y[0];
  assign {c1, sum[1]} = x[1] + y[1] + c0;
  assign {c2, sum[2]} = x[2] + y[2] + c1;
  assign {c3, sum[3]} = x[3] + y[3] + c2;
  assign sum[4] = c3;

endmodule