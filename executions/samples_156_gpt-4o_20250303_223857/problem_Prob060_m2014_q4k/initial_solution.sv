module TopModule (
    input  logic clk,        // Clock signal, active on the positive edge
    input  logic resetn,     // Active-low synchronous reset
    input  logic in,         // Serial input to the shift register
    output logic out         // Serial output from the shift register
);

    // Internal 4-bit shift register
    logic [3:0] shift_reg;

    // Sequential logic for shift register operation
    always_ff @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000; // Reset shift register to 0
        end else begin
            shift_reg <= {shift_reg[2:0], in}; // Shift left and input new bit
        end
    end

    // Assign the MSB of the shift register to the output
    assign out = shift_reg[3];

endmodule