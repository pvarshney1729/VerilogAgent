module TopModule (
    input  logic clk,
    input  logic resetn,
    input  logic in,
    output logic out
);
    logic [3:0] shift_reg;

    always @(posedge clk) begin
        if (!resetn)
            shift_reg <= 4'b0000;
        else
            shift_reg <= {shift_reg[2:0], in};
    end

    assign out = shift_reg[3];
endmodule