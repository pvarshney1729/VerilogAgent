module TopModule (
    input wire clk,           // Clock signal (positive edge-triggered)
    input wire a,             // Input signal 'a', 1-bit
    input wire b,             // Input signal 'b', 1-bit
    output wire out_assign,   // Output using assign statement, 1-bit
    output wire out_always_comb, // Output using combinational always block, 1-bit
    output reg out_always_ff  // Output using sequential always block, 1-bit
);

    // Continuous assignment for XOR logic
    assign out_assign = a ^ b;

    // Combinational logic block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Sequential logic block
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule