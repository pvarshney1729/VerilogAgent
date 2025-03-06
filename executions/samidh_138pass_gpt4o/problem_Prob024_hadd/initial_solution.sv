```verilog
[BEGIN]
module TopModule (
    input logic a,     // 1-bit input
    input logic b,     // 1-bit input
    output logic sum,  // 1-bit output: sum of a and b
    output logic cout  // 1-bit output: carry-out of a and b
);

    // Combinational logic for half adder
    always @(*) begin
        sum = a ^ b;   // XOR operation for sum
        cout = a & b;  // AND operation for carry-out
    end

endmodule
[DONE]
```