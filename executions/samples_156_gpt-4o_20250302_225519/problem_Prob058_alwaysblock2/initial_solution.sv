module TopModule(
    input logic clk,    // Clock signal, unsigned 1-bit
    input logic a,      // Input signal A, unsigned 1-bit
    input logic b,      // Input signal B, unsigned 1-bit
    output logic out_assign,       // XOR result using `assign` statement, unsigned 1-bit
    output logic out_always_comb,  // XOR result using combinational `always` block, unsigned 1-bit
    output logic out_always_ff     // XOR result using sequential `always` block, delayed by one clock cycle, unsigned 1-bit
);

    // XOR using assign statement
    assign out_assign = a ^ b;

    // XOR using combinational always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // XOR using sequential always block with clock
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule