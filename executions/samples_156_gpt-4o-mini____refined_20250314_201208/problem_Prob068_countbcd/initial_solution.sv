module TopModule (
    input  logic clk,
    input  logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    logic [3:0] ones, tens, hundreds, thousands;

    assign q = {thousands, hundreds, tens, ones};

    always @(posedge clk) begin
        if (reset) begin
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
            thousands <= 4'b0000;
        end else begin
            if (ones == 4'b1001) begin
                ones <= 4'b0000;
                if (tens == 4'b1001) begin
                    tens <= 4'b0000;
                    if (hundreds == 4'b1001) begin
                        hundreds <= 4'b0000;
                        if (thousands == 4'b1001) begin
                            thousands <= 4'b0000;
                        end else begin
                            thousands <= thousands + 1'b1;
                        end
                    end else begin
                        hundreds <= hundreds + 1'b1;
                    end
                end else begin
                    tens <= tens + 1'b1;
                end
            end else begin
                ones <= ones + 1'b1;
            end
        end
    end

    assign ena = {thousands != 4'b0000, hundreds != 4'b0000, tens != 4'b0000};

endmodule