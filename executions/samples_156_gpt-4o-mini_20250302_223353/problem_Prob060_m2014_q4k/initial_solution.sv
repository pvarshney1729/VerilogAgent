module TopModule (
    input logic clk,         // Clock input, positive edge-triggered
    input logic resetn,      // Active-low, synchronous reset
    input logic in,          // 1-bit data input
    output logic out         // 1-bit data output
);

    // Internal signals
    logic [3:0] shift_reg;    // 4-bit shift register to store internal state

    // Shift Register Implementation
    always @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000; // Reset state
        end else begin
            // Shift the register and input the new bit
            shift_reg <= {shift_reg[2:0], in};
        end
    end
    
    // Output Assignment
    assign out = shift_reg[3];

endmodule