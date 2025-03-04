module TopModule (
    input logic clk,          // Clock signal
    input logic rst,          // Active-high reset signal
    input logic [7:0] in,     // 8-bit input vector
    output logic [7:0] pedge  // 8-bit output vector for positive edge detection
);

    // Register to store the previous state of 'in'
    logic [7:0] in_prev;

    // Sequential logic to detect positive edges
    always_ff @(posedge clk) begin
        if (rst) begin
            // Reset behavior: Initialize pedge and in_prev to 0
            pedge <= 8'b0;
            in_prev <= 8'b0;
        end else begin
            // Detect positive edge for each bit
            pedge <= in & ~in_prev;
            // Update in_prev with the current state of 'in'
            in_prev <= in;
        end
    end

endmodule