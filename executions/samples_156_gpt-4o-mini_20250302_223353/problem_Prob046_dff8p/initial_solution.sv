module TopModule (
    input logic clk,           // Clock signal
    input logic reset,         // Active high synchronous reset
    input logic [7:0] d,       // 8-bit data input
    output logic [7:0] q        // 8-bit data output, registered
);

always @(negedge clk) begin
    if (reset) begin
        q <= 8'b00110100;    // Reset value 0x34
    end else begin
        q <= d;              // Regular D flip-flop operation
    end
end

endmodule