module TopModule (
    input logic clk,          // Clock signal
    input logic reset,        // Active high synchronous reset
    input logic [7:0] d,      // 8-bit data input
    output logic [7:0] q      // 8-bit data output
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000; // Reset output to zero
        end else begin
            q <= d;           // Capture input data
        end
    end

endmodule