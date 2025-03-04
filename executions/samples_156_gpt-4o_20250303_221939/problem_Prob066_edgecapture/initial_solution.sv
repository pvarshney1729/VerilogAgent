module TopModule (
    input wire clk,                      // Clock signal, triggers on the positive edge
    input wire reset,                    // Active high synchronous reset
    input wire [31:0] in,                // 32-bit input vector, unsigned
    output reg [31:0] out                // 32-bit output vector, unsigned
);

    reg [31:0] prev_in;                  // Register to store the previous state of input

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;                // Reset output to zero
            prev_in <= 32'b0;            // Reset previous input to zero
        end else begin
            out <= out | (prev_in & ~in); // Detect 1 to 0 transition and set out[i] to 1
            prev_in <= in;               // Update previous input
        end
    end

endmodule