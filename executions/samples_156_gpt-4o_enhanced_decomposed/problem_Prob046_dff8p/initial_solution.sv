module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    // Sequential logic with synchronous reset
    always_ff @(negedge clk) begin
        if (reset) begin
            q <= 8'b00110100; // Reset to 0x34
        end else begin
            q <= d; // Capture input d
        end
    end

endmodule