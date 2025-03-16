[BEGIN]
module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

    logic d_rising_edge, d_falling_edge;

    always @(posedge clk) begin
        d_rising_edge <= d;
    end

    always @(negedge clk) begin
        d_falling_edge <= d;
    end

    always_comb begin
        q = d_rising_edge ^ d_falling_edge;
    end

endmodule
[END]