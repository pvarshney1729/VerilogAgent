module TopModule(
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

    logic [9:0] count_reg;

    always @(posedge clk) begin
        if (reset) begin
            count_reg <= 10'b0;
        end else if (count_reg == 10'd999) begin
            count_reg <= 10'b0;
        end else begin
            count_reg <= count_reg + 1'b1;
        end
    end

    assign q = count_reg;

endmodule