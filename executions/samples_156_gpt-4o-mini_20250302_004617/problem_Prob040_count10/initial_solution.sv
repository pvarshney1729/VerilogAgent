module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] count
);

    logic [3:0] count_reg;

    always @(*) begin
        if (reset) begin
            count_reg = 4'b0000;
        end else begin
            count_reg = (count_reg == 4'b1001) ? 4'b0000 : count_reg + 1'b1;
        end
    end

    assign count = count_reg;

endmodule