module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 10'b0000000000; // Reset the counter to 0
        end else if (q == 10'd999) begin
            q <= 10'b0000000000; // Wrap around after reaching 999
        end else begin
            q <= q + 1'b1; // Increment the counter
        end
    end

endmodule