```verilog
[BEGIN]
module TopModule (
    input  logic [1:0] A,  // 2-bit input vector A (MSB: A[1], LSB: A[0])
    input  logic [1:0] B,  // 2-bit input vector B (MSB: B[1], LSB: B[0])
    output logic       z   // 1-bit output signal
);

    // Combinational logic to compare A and B
    always @(*) begin
        z = (A == B) ? 1'b1 : 1'b0;
    end

endmodule
[DONE]
```