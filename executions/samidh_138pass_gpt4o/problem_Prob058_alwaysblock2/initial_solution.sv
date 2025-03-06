[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_always_comb,
    output logic out_always_ff
);

    // XOR using assign statement
    assign out_assign = a ^ b;

    // XOR using combinational always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // XOR using clocked always block with synchronous reset
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
```
[DONE]