module TopModule (
    input logic clk,  // Clock signal (1-bit), positive edge-sensitive
    input logic d,    // Data input (1-bit)
    input logic r,    // Reset input (1-bit), active high
    output logic q    // Data output (1-bit)
);

initial begin
    q = 1'b0;  // Initialize output to 0
end

always @(posedge clk) begin
    if (r) begin
        q <= 1'b0;  // Reset output to 0
    end else begin
        q <= d;     // Capture data input
    end
end

endmodule