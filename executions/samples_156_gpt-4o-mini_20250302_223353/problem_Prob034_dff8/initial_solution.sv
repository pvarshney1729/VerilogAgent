module TopModule (
    input logic clk,         // Clock signal
    input logic rst,         // Synchronous reset
    input logic [7:0] d,     // 8-bit input data
    output logic [7:0] q      // 8-bit output data
);

    always @(posedge clk) begin
        if (rst) begin
            q <= 8'b00000000;  // Reset state
        end else begin
            q <= d;            // Capture input
        end
    end

endmodule