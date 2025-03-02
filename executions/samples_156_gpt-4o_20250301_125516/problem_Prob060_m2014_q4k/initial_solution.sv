module ShiftRegister4Bit (
    input logic clk,            // Clock signal, positive edge-triggered
    input logic resetn,         // Active-low synchronous reset signal
    input logic in,             // Serial input to the shift register
    output logic out            // Output from the most significant bit of the shift register
);

// Shift Register Internal State
logic [3:0] shift_reg; // 4-bit register to hold the state of the shift register

// Sequential logic for shift register
always_ff @(posedge clk) begin
    if (~resetn) begin
        shift_reg <= 4'b0000; // Reset state
    end else begin
        shift_reg <= {shift_reg[2:0], in}; // Shift left and insert 'in' at LSB
    end
end

// Continuous assignment for output
assign out = shift_reg[3]; // Output the MSB

endmodule