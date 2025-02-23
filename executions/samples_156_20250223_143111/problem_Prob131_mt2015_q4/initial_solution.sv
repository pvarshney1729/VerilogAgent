module A
(
  input  logic x,
  input  logic y,
  output logic z
);
  assign z = (x ^ y) & x;
endmodule

module B
(
  input  logic x,
  input  logic y,
  output logic z
);
  initial begin
    z = 1;
    #25 z = (x & y);
    #20 z = 1;
    #10 z = (x & y);
  end
endmodule

module TopModule
(
  input  logic x,
  input  logic y,
  output logic z
);

  wire a1_out, a2_out, b1_out, b2_out;
  wire or_out, and_out;

  A a1 (.x(x), .y(y), .z(a1_out));
  A a2 (.x(x), .y(y), .z(a2_out));
  B b1 (.x(x), .y(y), .z(b1_out));
  B b2 (.x(x), .y(y), .z(b2_out));

  assign or_out  = a1_out | b1_out;
  assign and_out = a2_out & b2_out;

  assign z = or_out ^ and_out;

endmodule