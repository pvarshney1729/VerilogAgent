module TopModule (
    input logic clk,        // Clock signal
    input logic resetn,     // Active-low, synchronous reset
    input logic in,         // Serial input data
    output logic out        // Serial output data
);

    // 4-bit shift register
    logic [3:0] shift_reg;

    // Sequential logic for shift register
    always_ff @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000; // Reset all bits to 0
        end else begin
            shift_reg <= {shift_reg[2:0], in}; // Shift left and load new bit
        end
    end

    // Output the MSB of the shift register
    assign out = shift_reg[3];

endmodule