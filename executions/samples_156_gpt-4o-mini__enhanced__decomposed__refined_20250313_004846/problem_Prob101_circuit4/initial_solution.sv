```verilog
module TopModule (
    input logic a,  // Input signal 'a', 1-bit width
    input logic b,  // Input signal 'b', 1-bit width
    input logic c,  // Input signal 'c', 1-bit width
    input logic d,  // Input signal 'd', 1-bit width
    output logic q   // Output signal 'q', 1-bit width
);

    always @(*) begin
        q = ((b | c) & ~a) | (c & d);
    end

endmodule
```