[BEGIN]
module TopModule (
    logic p1a,
    logic p1b,
    logic p1c,
    logic p1d,
    logic p2a,
    logic p2b,
    logic p2c,
    logic p2d,
    logic p1y,
    logic p2y
);

    always @(*) begin
        p1y = ~(p1a & p1b & p1c & p1d);
        p2y = ~(p2a & p2b & p2c & p2d);
    end

endmodule
[DONE]