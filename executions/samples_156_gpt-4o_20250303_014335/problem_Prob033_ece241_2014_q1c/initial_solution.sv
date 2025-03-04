module TopModule (
  input signed [7:0] a,
  input signed [7:0] b,
  output reg signed [7:0] s,
  output reg overflow
);
  always @(*) begin
    s = a + b;
    // Overflow is set if the sign of a and b is the same and differs from s
    overflow = ((a[7] == b[7]) && (s[7] != a[7]));
  end
endmodule