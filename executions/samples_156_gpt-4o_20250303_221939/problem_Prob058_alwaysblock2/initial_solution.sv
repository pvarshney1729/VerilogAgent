```verilog
module TopModule (
    input wire clk,
    input wire a,
    input wire b,
    output wire out_assign,
    output wire out_always_comb,
    output reg out_always_ff
);

    // Assign statement for XOR operation
    assign out_assign = a ^ b;

    // Combinational always block for XOR operation
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Clocked always block for XOR operation
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
```