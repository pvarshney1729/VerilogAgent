module TopModule (
    logic clk,
    logic reset,
    logic a,
    logic [2:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 3'b000;
    end else if (a) begin
        if (q == 3'b111) begin
            q <= 3'b000;
        end else begin
            q <= q + 1;
        end
    end
end

endmodule