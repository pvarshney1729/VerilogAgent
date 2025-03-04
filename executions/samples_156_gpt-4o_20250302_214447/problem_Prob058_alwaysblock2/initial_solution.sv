module TopModule (
    input logic clk,           // Clock signal
    input logic reset_n,       // Asynchronous active-low reset
    input logic a,             // 1-bit input
    input logic b,             // 1-bit input
    output logic out_assign,   // 1-bit output for XOR using assign
    output logic out_always_comb, // 1-bit output for XOR using always_comb
    output logic out_always_ff     // 1-bit output for XOR using always_ff (sequential)
);

    // XOR using assign
    assign out_assign = a ^ b;

    // XOR using always_comb
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // XOR using always_ff with flip-flop
    always @(posedge clk) begin
        if (!reset_n)
            out_always_ff <= 1'b0; // Reset to 0
        else
            out_always_ff <= a ^ b;
    end

endmodule