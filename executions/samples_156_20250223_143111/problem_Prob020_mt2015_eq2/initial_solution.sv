module TopModule
(
  input  logic [1:0] A,
  input  logic [1:0] B,
  output logic       z
);

  // Combinational logic

  assign z = (A == B) ? 1 : 0;

endmodule