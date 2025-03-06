module TopModule (
    input  logic clk,          // Clock signal, single-bit, positive edge-triggered
    input  logic reset,        // Synchronous reset signal, single-bit
    input  logic a,            // Input signal 'a', single-bit, unsigned
    input  logic b,            // Input signal 'b', single-bit, unsigned
    output logic out_assign,   // Output for assign-based XOR, single-bit
    output logic out_always_comb, // Output for combinational always block XOR, single-bit
    output logic out_always_ff // Output for sequential always block XOR, single-bit
);

    // Implement XOR using assign statement
    assign out_assign = a ^ b;

    // Implement XOR using a combinational always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Implement XOR using a sequential always block with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            out_always_ff <= 1'b0; // Reset state
        end else begin
            out_always_ff <= a ^ b;
        end
    end

endmodule