module TopModule
(
  input  logic clock,
  input  logic a,
  output logic p,
  output logic q
);

  // Sequential logic

  always @( posedge clock ) begin
    p <= a;
    q <= p;
  end

endmodule