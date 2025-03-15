module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    // Initialize q to 0x34 for simulation purposes
    initial begin
        q = 8'h34;
    end

    // Sequential logic for D flip-flops with synchronous reset
    always @(negedge clk) begin
        if (reset) begin
            q <= 8'h34; // Reset to 0x34 on reset
        end else begin
            q <= d; // Capture input d on negative edge of clk
        end
    end
endmodule