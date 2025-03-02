module shift_register (
    input logic clk,
    input logic areset,
    input logic load,
    input logic ena,
    input logic [3:0] data_in,
    output logic [3:0] data_out
);

    logic [3:0] shift_reg;

    always @(*) begin
        if (areset) begin
            shift_reg = 4'b0000;
        end else if (load) begin
            shift_reg = data_in;
        end else if (ena) begin
            shift_reg = {1'b0, shift_reg[3:1]}; // Right shift
        end
    end

    assign data_out = shift_reg;

endmodule