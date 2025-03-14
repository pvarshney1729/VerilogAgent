[BEGIN]
module TopModule (
    input logic clk,  // Clock input, samples on rising edge
    input logic d,    // Data input
    input logic r,    // Synchronous reset input, active high
    output logic q    // Output, holds the state of the D flip-flop
);

    always_ff @(posedge clk) begin
        if (r) begin
            q <= 1'b0;  // Reset output to 0
        end else begin
            q <= d;     // Latch data on rising edge of clk
        end
    end

endmodule
[DONE]