module TopModule (
    input logic clk,             // Clock signal
    input logic reset,           // Active high synchronous reset
    input logic [31:0] in,       // 32-bit input vector
    output logic [31:0] out      // 32-bit output vector
);

    // Internal register to store previous state of 'in'
    logic [31:0] prev_in;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'd0;  // Reset the output vector to 0
        end else begin
            // Detect transitions from 1 to 0
            out <= out | (prev_in & ~in);
        end
        // Update previous input state
        prev_in <= in;
    end
endmodule