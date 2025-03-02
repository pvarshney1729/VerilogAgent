module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic async_reset,  // Asynchronous active-high reset
    input logic a,            // Single-bit input
    input logic b,            // Single-bit input
    output logic out_assign,  // Single-bit output for assign statement-based XOR
    output logic out_always_comb, // Single-bit output for combinational always block-based XOR
    output logic out_always_ff    // Single-bit output for clocked always block-based XOR
);

    // Assign statement-based XOR
    assign out_assign = a ^ b;

    // Combinational always block-based XOR
    always_comb begin
        out_always_comb = a ^ b;
    end

    // Clocked always block-based XOR with asynchronous reset
    always_ff @(posedge clk or posedge async_reset) begin
        if (async_reset) begin
            out_always_ff <= 1'b0;
        end else begin
            out_always_ff <= a ^ b;
        end
    end

endmodule