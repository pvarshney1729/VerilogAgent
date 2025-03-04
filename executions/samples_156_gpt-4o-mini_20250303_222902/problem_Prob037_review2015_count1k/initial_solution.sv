module TopModule (
    logic clk,
    logic reset,
    logic [9:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 10'b0000000000; // Reset counter to 0
    end else begin
        if (q == 10'd999) begin
            q <= 10'b0000000000; // Wrap around to 0
        end else begin
            q <= q + 1; // Increment counter
        end
    end
end

endmodule