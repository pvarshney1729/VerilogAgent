module TopModule (
    input logic clk,  // Clock input
    input logic d,    // Data input
    input logic r,    // Active high synchronous reset
    output logic q    // Flip flop output
);

always @(posedge clk) begin
    if (r) begin
        q <= 1'b0;  // Reset output to 0
    end else begin
        q <= d;     // Capture data input
    end
end

endmodule