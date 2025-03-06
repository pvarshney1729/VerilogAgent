```verilog
[BEGIN]
module TopModule (
    input logic a, // 1-bit unsigned input
    input logic b, // 1-bit unsigned input
    input logic c, // 1-bit unsigned input
    input logic d, // 1-bit unsigned input
    output logic q // 1-bit unsigned output
);

    always @(*) begin
        q = (a & ~b & c) | (~a & b & ~c & d) | (a & b & ~c & ~d) | (~a & ~b & c & d) | (~a & ~b & ~c & 1'b0);
    end

endmodule
[DONE]
```