module TopModule (
    input  logic        clk,    // Clock input
    input  logic        reset,  // Active high synchronous reset
    input  logic [31:0] in,     // 32-bit input vector, unsigned
    output logic [31:0] out     // 32-bit output vector, unsigned
);

    logic [31:0] prev_in; // Register to hold the previous state of 'in'

    // Sequential logic to capture 1-to-0 transitions
    always_ff @(posedge clk) begin
        if (reset) begin
            out <= 32'b0; // Reset output to zero
            prev_in <= 32'b0; // Reset previous input to zero
        end else begin
            // Detect 1-to-0 transitions and set corresponding bits in 'out'
            out <= out | (prev_in & ~in);
            // Update previous input
            prev_in <= in;
        end
    end

endmodule