```verilog
module TopModule (
    input wire clk,
    input wire rst_n, // Active-low reset
    input wire a,
    input wire b,
    output wire out_assign,
    output wire out_always_comb,
    output reg out_always_ff
);

    // Continuous assignment for XOR operation
    assign out_assign = a ^ b;

    // Combinational logic using always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Sequential logic with flip-flop
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            out_always_ff <= 1'b0; // Reset state
        else
            out_always_ff <= a ^ b;
    end

endmodule
```