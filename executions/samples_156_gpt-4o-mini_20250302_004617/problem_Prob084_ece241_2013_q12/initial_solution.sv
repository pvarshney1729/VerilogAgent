module shift_register (
    input logic clk,
    input logic rst,
    input logic [7:0] data_in,
    input logic shift,
    input logic [2:0] addr,
    output logic [7:0] Z
);
    logic [7:0] shift_reg;

    always @(*) begin
        case (addr)
            3'b000: Z = shift_reg[0];
            3'b001: Z = shift_reg[1];
            3'b010: Z = shift_reg[2];
            3'b011: Z = shift_reg[3];
            3'b100: Z = shift_reg[4];
            3'b101: Z = shift_reg[5];
            3'b110: Z = shift_reg[6];
            3'b111: Z = shift_reg[7];
            default: Z = 1'b0;
        endcase
    end

    always @(*) begin
        if (rst) begin
            shift_reg = 8'b00000000;
        end else if (shift) begin
            shift_reg = {shift_reg[6:0], data_in[0]};
        end else begin
            shift_reg = shift_reg;
        end
    end
endmodule