[BEGIN]
module TopModule (
    input  logic clk,        // Clock signal, positive edge triggered
    input  logic resetn,     // Active-low synchronous reset signal
    input  logic in,         // Serial input data bit
    output logic out         // Serial output data bit
);
    logic [3:0] shift_reg;    // 4-bit shift register

    always @(posedge clk) begin
        if (~resetn) begin
            shift_reg <= 4'b0000; // Reset the shift register
        end else begin
            shift_reg <= {shift_reg[2:0], in}; // Shift left and insert new bit
        end
    end

    always @(posedge clk) begin
        out <= shift_reg[3]; // MSB output
    end
endmodule
[DONE]