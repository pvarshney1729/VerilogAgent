module TopModule (
    input logic clk,          // Clock input, positive edge-triggered
    input logic reset,        // Synchronous active-high reset input
    input logic [7:0] d,      // 8-bit data input
    output logic [7:0] q      // 8-bit data output
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000;  // Reset output to all zeros
        end else begin
            q <= d;            // Capture input data
        end
    end

endmodule