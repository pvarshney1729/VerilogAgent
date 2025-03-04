module TopModule(
    input logic clk,        // Clock input, positive edge-triggered
    input logic reset,      // Active-high synchronous reset
    output logic [3:0] q    // 4-bit output, unsigned
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'd1;
        end else if (q == 4'd10) begin
            q <= 4'd1;
        end else begin
            q <= q + 4'd1;
        end
    end

endmodule