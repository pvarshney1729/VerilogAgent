module TopModule (
    input logic clk,
    input logic reset,
    input logic slowena,
    output logic [3:0] count
);

    logic [3:0] count_reg;

    always @(*) begin
        if (reset) begin
            count_reg = 4'b0000;
        end else if (slowena) begin
            if (count_reg == 4'b1001) begin
                count_reg = 4'b0000;
            end else begin
                count_reg = count_reg + 4'b0001;
            end
        end else begin
            count_reg = count_reg; // Hold current value if slowena is not asserted
        end
    end

    assign count = count_reg;

endmodule