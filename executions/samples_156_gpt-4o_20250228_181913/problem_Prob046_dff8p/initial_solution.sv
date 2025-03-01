module TopModule (
    input logic clk,       // 1-bit clock signal, active on the negative edge
    input logic reset,     // 1-bit active-high synchronous reset signal
    input logic [7:0] d,   // 8-bit data input, LSB is d[0]
    output logic [7:0] q   // 8-bit data output, LSB is q[0]
);

    // Sequential logic for D flip-flops with synchronous reset
    always_ff @(negedge clk) begin
        if (reset) begin
            q <= 8'b00110100; // Reset state to 0x34
        end else begin
            q <= d; // Capture input d on negative edge of clk
        end
    end

endmodule