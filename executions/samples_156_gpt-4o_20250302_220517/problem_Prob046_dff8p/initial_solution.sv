module TopModule (
    input logic clk,                  // Clock signal, negative edge-triggered
    input logic reset,                // Active high synchronous reset
    input logic [7:0] d,              // 8-bit data input, d[7] is MSB, d[0] is LSB
    output logic [7:0] q              // 8-bit output, q[7] is MSB, q[0] is LSB
);

    always @(negedge clk) begin
        if (reset) begin
            q <= 8'b00110100;         // Reset value 0x34
        end else begin
            q <= d;                   // Update output with input data
        end
    end

endmodule