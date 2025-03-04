module TopModule (
  input [2:0] vec,
  output [2:0] outv,
  output o0,
  output o1,
  output o2
);

  // Direct assignments from input to outputs
  assign outv = vec;
  assign o0 = vec[0];
  assign o1 = vec[1];
  assign o2 = vec[2];

endmodule