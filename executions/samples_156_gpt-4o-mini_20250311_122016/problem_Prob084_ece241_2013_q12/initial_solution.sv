```
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset_n,
    input logic enable,
    input logic S,
    input logic A,
    input logic B,
    input logic C,
    output logic Z
);
    logic [7:0] shift_reg;
    logic [2:0] address = {A, B, C};

    // Shift Register Logic
    always @(posedge clk) begin
        if (!reset_n)
            shift_reg <= 8'b0;
        else if (enable)
            shift_reg <= {shift_reg[6:0], S};
    end

    // Multiplexer Logic
    always @(*) begin
        case (address)
            3'b000: Z = shift_reg[0];
            3'b001: Z = shift_reg[1];
            3'b010: Z = shift_reg[2];
            3'b011: Z = shift_reg[3];
            3'b100: Z = shift_reg[4];
            3'b101: Z = shift_reg[5];
            3'b110: Z = shift_reg[6];
            3'b111: Z = shift_reg[7];
            default: Z = 1'b0; // Don't-care condition
        endcase
    end

endmodule
[DONE]
```