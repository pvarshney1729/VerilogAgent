module TopModule (
    input logic clk,  // Clock signal, positive edge-triggered
    input logic d,    // Data input for the D flip-flop
    input logic r,    // Synchronous reset input, active high
    output logic q    // Output of the D flip-flop
);

    always_ff @(posedge clk) begin
        if (r) begin
            q <= 1'b0;  // Reset output to 0 when reset is high
        end else begin
            q <= d;     // Capture data input on rising edge of clock
        end
    end

endmodule