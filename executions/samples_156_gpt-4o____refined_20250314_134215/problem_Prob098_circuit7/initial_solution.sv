[BEGIN]
module TopModule (
    input  logic clk,
    input  logic a,
    output logic q
);

    logic q_reg;

    always_ff @(posedge clk) begin
        if (a == 1'b1) begin
            q_reg <= 1'b0;
        end else begin
            q_reg <= 1'b1;
        end
    end

    assign q = q_reg;

endmodule
[DONE]