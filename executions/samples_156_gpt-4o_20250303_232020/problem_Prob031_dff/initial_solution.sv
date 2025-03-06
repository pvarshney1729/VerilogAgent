module TopModule (
    input logic clk,     // Clock signal
    input logic d,       // Data input
    input logic reset,   // Synchronous reset
    output logic q       // Data output
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;  // Reset state
        end else begin
            q <= d;     // Capture input
        end
    end

endmodule