module TopModule (
    input logic clk,          // Clock signal, used for sequential logic
    input logic a,            // 1-bit input signal
    input logic b,            // 1-bit input signal
    output logic out_assign,  // 1-bit output, result of XOR via assign statement
    output logic out_always_comb, // 1-bit output, result of XOR via combinational always block
    output logic out_always_ff // 1-bit output, result of XOR via sequential logic with flip-flop
);

    // XOR operation using assign statement
    assign out_assign = a ^ b;

    // XOR operation using combinational always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // XOR operation using sequential logic with flip-flop
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule