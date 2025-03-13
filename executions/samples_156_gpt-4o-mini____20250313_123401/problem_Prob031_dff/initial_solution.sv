module TopModule (
    input logic clk,
    input logic d,
    input logic q
);
    logic q_reg;

    always @(posedge clk) begin
        q_reg <= d;
    end

    assign q = q_reg;

endmodule