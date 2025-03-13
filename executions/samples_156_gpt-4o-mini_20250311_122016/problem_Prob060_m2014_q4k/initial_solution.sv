[BEGIN]
module TopModule (
    input logic clk,          // Clock signal, triggers on positive edge
    input logic resetn,       // Active-low synchronous reset
    input logic in,           // Serial input to the shift register
    output logic out          // Output from the last flip-flop in the register
);

    logic [3:0] shift_reg;     // 4-bit shift register

    always @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000; // Reset all flip-flops to 0
        end else begin
            shift_reg <= {shift_reg[2:0], in}; // Shift right and load input
        end
    end

    assign out = shift_reg[3]; // Output from the last flip-flop

endmodule
[DONE]