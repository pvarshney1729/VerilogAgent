[BEGIN]
module TopModule (
  input logic in1,
  input logic in2,
  output logic out
);

  always @(*) begin
    out = ~(in1 | in2); // Using explicit size for numeric constants
  end

endmodule
[DONE]