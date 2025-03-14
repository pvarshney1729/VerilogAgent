```verilog
// BEGIN
module TopModule (
    input logic a,  // Input signal a (bit[0])
    input logic b,  // Input signal b (bit[1])
    input logic c,  // Input signal c (bit[2])
    input logic d,  // Input signal d (bit[3], don't-care condition)
    output logic out // Output signal out
);

always @(*) begin
    out = (b & c) | (a & b) | (a & c);
end

endmodule
// DONE
```