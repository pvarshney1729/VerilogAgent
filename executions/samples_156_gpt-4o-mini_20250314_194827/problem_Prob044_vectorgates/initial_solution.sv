module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [2:0] a,
    input logic [2:0] b,
    output logic [2:0] bitwise_or,
    output logic [2:0] logical_or,
    output logic [2:0] not_a
);

    always @(*) begin
        bitwise_or = a | b;
        logical_or = {a[2] | b[2], a[1] | b[1], a[0] | b[0]};
        not_a = ~a;
    end

    always @(posedge clk) begin
        if (!rst_n) begin
            bitwise_or <= 3'b000;
            logical_or <= 3'b000;
            not_a <= 3'b000;
        end
    end

endmodule