module TopModule (
    input logic clk,  // Clock signal, positive edge-triggered
    input logic ar,   // Asynchronous reset signal, active high
    input logic d,    // Data input
    output logic q    // Data output
);

always @(posedge clk or posedge ar) begin
    if (ar) begin
        q <= 1'b0;  // Reset state
    end else begin
        q <= d;     // Data storage
    end
end

endmodule