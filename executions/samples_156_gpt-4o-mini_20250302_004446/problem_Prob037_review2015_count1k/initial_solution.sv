module TopModule (
    logic clk,
    logic reset,
    logic [9:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 10'b0; // Reset counter to 0
    end else if (q == 10'd999) begin
        q <= 10'b0; // Roll over to 0 after reaching 999
    end else begin
        q <= q + 10'b1; // Increment counter
    end
end

endmodule