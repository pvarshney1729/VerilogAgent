module TopModule (
    input logic clk,   // Clock signal, 1-bit, active on rising edge.
    input logic ar,    // Asynchronous reset signal, 1-bit, active high.
    input logic d,     // Data input, 1-bit.
    output logic q     // Data output, 1-bit.
);

    always_ff @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0; // Asynchronous reset to 0
        end else begin
            q <= d;    // Capture data on rising edge of clock
        end
    end

endmodule