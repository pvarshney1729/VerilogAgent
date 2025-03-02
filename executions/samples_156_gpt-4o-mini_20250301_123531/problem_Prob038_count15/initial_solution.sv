module TopModule (
    logic clk,
    logic reset,
    logic [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000;
    end else begin
        q <= q + 1;
    end
end

endmodule