module counter (
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] count
);

    logic [1:0] count_reg;

    always @(*) begin
        if (areset) begin
            count_reg = 2'b01;
        end else if (train_valid) begin
            if (train_taken) begin
                count_reg = count_reg + 1'b1;
            end else begin
                count_reg = count_reg - 1'b1;
            end
        end
    end

    assign count = count_reg;

endmodule