module TopModule (
    logic clk,
    logic d,
    logic rst_n, // Active-low reset
    logic q
);

// D Flip-Flop with asynchronous reset
always @(posedge clk) begin
    if (!rst_n) begin
        q <= 1'b0; // Asynchronous reset
    end else begin
        q <= d;    // Data capture on clock edge
    end
end

endmodule