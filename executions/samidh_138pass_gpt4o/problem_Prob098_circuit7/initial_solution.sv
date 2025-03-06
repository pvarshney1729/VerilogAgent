module TopModule (
    input logic clk,   // Clock signal, positive edge-triggered
    input logic a,     // Single-bit input signal
    input logic rst_n, // Asynchronous active-low reset
    output logic q     // Single-bit output signal, sequential
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 1'b0;  // Reset to 0
        end else if (a == 1'b0) begin
            q <= ~q;    // Toggle q
        end
        // If a == 1, retain the current state of q.
    end
endmodule