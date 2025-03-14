module TopModule (
    input logic clk,    // Clock input (1-bit, unsigned)
    input logic d,      // Data input (1-bit, unsigned)
    output logic q      // Output (1-bit, unsigned)
);

    initial begin
        q = 1'b0; // Initialize output to 0
    end

    always @(posedge clk) begin
        q <= d; // Capture data on rising edge
    end

    always @(negedge clk) begin
        q <= d; // Capture data on falling edge
    end

endmodule