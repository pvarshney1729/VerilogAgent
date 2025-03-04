module TopModule (
    input logic clk,  // Clock signal, positive edge triggered
    input logic ar,   // Asynchronous reset signal, active high
    input logic d,    // Data input signal
    output logic q    // Data output signal (1-bit)
);

always_ff @(posedge clk or posedge ar) begin
    if (ar) begin
        q <= 1'b0;  // Reset state
    end else begin
        q <= d;     // Capture data on positive clock edge
    end
end

endmodule