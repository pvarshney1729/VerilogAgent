module TopModule(
    input wire clk,            // Clock signal, negative edge triggered
    input wire reset,          // Active high synchronous reset
    input wire [7:0] d,        // 8-bit data input, d[0] is LSB
    output reg [7:0] q         // 8-bit data output, q[0] is LSB
);

    always @(negedge clk) begin
        if (reset) begin
            q <= 8'b00110100;  // Set q to 0x34 on reset
        end else begin
            q <= d;            // Propagate d to q
        end
    end

endmodule