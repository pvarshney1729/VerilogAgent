module TopModule (
    input logic clk,           // Clock signal; positive edge triggered
    input logic reset,         // Synchronous reset signal, active high
    input logic d,             // Data input for the D flip-flop
    output logic q             // Output representing the stored state
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;         // Reset output to 0
        end else begin
            q <= d;            // Capture data input on rising edge of clk
        end
    end

endmodule