module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Synchronous reset and counter logic
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Synchronous reset to 0
        end else if (q == 4'b1001) begin
            q <= 4'b0000; // Reset to 0 after reaching 9
        end else begin
            q <= q + 1; // Increment counter
        end
    end

endmodule