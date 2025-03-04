module TopModule (
    input logic clk,             // 1-bit clock input
    input logic reset,           // 1-bit synchronous active-high reset input
    output logic [3:0] q         // 4-bit output representing the counter value
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset counter
        end else begin
            q <= q + 1;   // Increment counter
        end
    end

endmodule