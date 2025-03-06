```verilog
[BEGIN]
module TopModule (
    input  logic [7:0] in,     // 8-bit input vector 'in', where bit[0] is the LSB and bit[7] is the MSB
    output logic       parity   // 1-bit output 'parity' representing the even parity bit
);

    // Calculate the even parity bit using XOR reduction
    always @(*) begin
        parity = ^in; // Calculate parity
    end

endmodule
[DONE]
```