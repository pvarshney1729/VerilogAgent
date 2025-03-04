```verilog
module TopModule (
    input logic clk,          // Clock signal
    input logic reset_n,      // Active-low synchronous reset
    input logic a,            // Input signal a
    input logic b,            // Input signal b
    output logic out_assign,  // Output signal using assign statement
    output logic out_always_comb, // Output signal using always_comb block
    output logic out_always_ff // Output signal using always_ff block
);

    // Implement XOR using assign statement
    assign out_assign = a ^ b;

    // Implement XOR using always_comb block
    always_comb begin
        out_always_comb = a ^ b;
    end

    // Implement XOR using always_ff block with synchronous reset
    always_ff @(posedge clk) begin
        if (!reset_n)
            out_always_ff <= 1'b0;
        else
            out_always_ff <= a ^ b;
    end

endmodule
```