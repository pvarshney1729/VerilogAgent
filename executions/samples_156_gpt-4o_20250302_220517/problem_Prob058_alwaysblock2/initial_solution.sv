module TopModule (
    input logic clk,        // Clock signal for sequential logic
    input logic a,          // Single-bit input
    input logic b,          // Single-bit input
    output logic out_assign,            // XOR output using assign statement
    output logic out_always_comb,       // XOR output using combinational always block
    output logic out_always_ff          // XOR output using sequential always block with flip-flop
);

    // Combinational Logic using assign statement
    assign out_assign = a ^ b;

    // Combinational Logic using always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Sequential Logic using always block with flip-flop
    always_ff @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule