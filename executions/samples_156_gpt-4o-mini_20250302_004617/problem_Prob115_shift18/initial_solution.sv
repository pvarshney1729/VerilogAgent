module TopModule (
    input logic clk,
    input logic reset_n,
    input logic load,
    input logic ena,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

    logic [7:0] reg_data;

    always @(*) begin
        if (!reset_n) begin
            reg_data = 8'b0;
        end else if (load) begin
            reg_data = data_in;
        end else if (ena) begin
            reg_data = reg_data >> 1; // Arithmetic shift right
        end
    end

    assign data_out = reg_data;

endmodule