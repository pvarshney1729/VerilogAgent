module TopModule (
    input logic clk,         // Clock signal, negative edge triggered
    input logic reset,       // Synchronous active-high reset signal
    input logic [7:0] d,     // 8-bit data input
    output logic [7:0] q     // 8-bit data output
);

    always_ff @(negedge clk) begin
        if (reset) begin
            q <= 8'h34;      // Set q to 8'h34 on reset
        end else begin
            q <= d;          // Capture input d on negative edge of clk
        end
    end

endmodule