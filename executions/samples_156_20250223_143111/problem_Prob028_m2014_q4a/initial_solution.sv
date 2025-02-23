module TopModule
(
  input  logic d,
  input  logic ena,
  output logic q
);

  // Sequential logic

  always @( * ) begin
    if ( ena )
      q <= d;
  end

endmodule