module TopModule (
    input logic clk,
    input logic reset,
    input logic enable,
    output logic [3:0] count,
    output logic ena
);

    logic [3:0] count_reg;

    // Synchronous reset and counter increment
    always @(*) begin
        if (reset) begin
            count_reg = 4'b0000;
            ena = 1'b0;
        end else if (enable) begin
            count_reg = count_reg + 4'b0001;
            ena = 1'b1;
        end else begin
            ena = 1'b0;
        end
    end

    // Assign count output
    assign count = count_reg;

endmodule