module TopModule (
    input logic clk,
    input logic resetn,
    input logic in,
    output logic out
);
    logic [3:0] shift_reg;

    always @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000;
        end else begin
            shift_reg[3] <= shift_reg[2];
            shift_reg[2] <= shift_reg[1];
            shift_reg[1] <= shift_reg[0];
            shift_reg[0] <= in;
        end
    end

    assign out = shift_reg[3];
endmodule