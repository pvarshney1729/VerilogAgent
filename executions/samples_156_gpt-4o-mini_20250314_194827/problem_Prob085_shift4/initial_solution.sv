module shift_register (
    input logic clk,
    input logic rst_n,
    input logic load,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

    logic [7:0] shift_reg;

    always @(*) begin
        if (!rst_n) begin
            shift_reg = 8'b00000000;
        end else if (load) begin
            shift_reg = data_in;
        end else begin
            shift_reg = {shift_reg[6:0], 1'b0}; // Shift left and fill with 0
        end
    end

    assign data_out = shift_reg;

endmodule