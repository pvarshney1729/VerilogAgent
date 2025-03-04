module TopModule (
    input logic clk,                // Clock signal, positive edge triggered
    input logic reset,              // Active high synchronous reset
    input logic [31:0] in,          // 32-bit input vector, unsigned
    output logic [31:0] out         // 32-bit output vector, unsigned
);

    logic [31:0] prev_in;           // Register to store the previous value of 'in'

    always_ff @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;           // Reset output to 0
            prev_in <= 32'b0;       // Reset previous input to 0
        end else begin
            out <= out | (prev_in & ~in); // Detect 1 to 0 transition and set corresponding bits in 'out'
            prev_in <= in;          // Update previous input with current input
        end
    end

endmodule