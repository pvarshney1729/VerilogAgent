module TopModule (
    input wire clk,   // Clock signal, rising edge-triggered
    input wire d,     // Data input
    input wire r,     // Synchronous reset, active high
    output reg q      // Output
);

    // Initial state
    initial begin
        q = 1'b0;
    end

    // D flip-flop with synchronous reset
    always @(posedge clk) begin
        if (r) begin
            q <= 1'b0;  // Reset output
        end else begin
            q <= d;     // Capture input
        end
    end

endmodule