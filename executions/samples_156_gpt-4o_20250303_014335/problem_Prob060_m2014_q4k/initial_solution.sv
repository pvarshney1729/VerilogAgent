module TopModule (
    input logic clk,
    input logic reset_n,
    input logic in,
    output logic out
);

    logic [3:0] shift_reg;

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            shift_reg <= 4'b0000;
        end else begin
            shift_reg <= {shift_reg[2:0], in};
        end
    end

    assign out = shift_reg[3];

endmodule