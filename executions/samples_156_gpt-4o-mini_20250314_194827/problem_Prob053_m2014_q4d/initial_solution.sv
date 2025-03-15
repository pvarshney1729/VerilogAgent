module simple_flip_flop (
    input logic clk,
    input logic in,
    output logic q
);

    always @(posedge clk) begin
        q <= in;
    end

    initial begin
        q = 1'b0;
    end

endmodule