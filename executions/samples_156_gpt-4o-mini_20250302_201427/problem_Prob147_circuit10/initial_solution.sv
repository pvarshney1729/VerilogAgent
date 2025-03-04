module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

always @(*) begin
    q = a ^ b;
end

always @(posedge clk) begin
    state <= q;
end

initial begin
    q = 1'bx;
    state = 1'bx;
end

endmodule