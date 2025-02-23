module TopModule
(
  input  logic x,
  input  logic y,
  output logic z
);

  // Combinational logic

  assign z = (x ^ y) & x;

endmodule