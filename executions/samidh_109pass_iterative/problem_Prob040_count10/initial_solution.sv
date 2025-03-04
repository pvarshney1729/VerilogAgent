module TopModule (
    input logic clk,           // Clock signal, positive edge triggered
    input logic reset,         // Active high synchronous reset
    output logic [3:0] q       // 4-bit output, unsigned, MSB is q[3], LSB is q[0]
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;      // Reset counter to 0
        end else if (q == 4'b1001) begin
            q <= 4'b0000;      // Wrap from 9 to 0
        end else begin
            q <= q + 1'b1;     // Increment counter
        end
    end

endmodule