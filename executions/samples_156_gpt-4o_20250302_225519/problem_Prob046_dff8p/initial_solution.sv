module TopModule (
    input wire clk,           // 1-bit clock input
    input wire reset,         // 1-bit synchronous active high reset input
    input wire [7:0] d,       // 8-bit data input, unsigned
    output reg [7:0] q        // 8-bit data output, unsigned
);

    always @(negedge clk) begin
        if (reset) begin
            q <= 8'b00110100; // Set to 0x34 on reset
        end else begin
            q <= d; // Load data from input
        end
    end

endmodule