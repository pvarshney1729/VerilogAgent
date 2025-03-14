```verilog
module TopModule (
    input logic clk,              // Clock signal, active on the positive edge
    input logic resetn,          // Active-low synchronous reset signal
    input logic in,              // Input signal for the shift register, 1 bit
    output logic out             // Output signal, 1 bit representing the last shifted bit
);

    logic [3:0] shift_reg;        // 4-bit shift register

    // Initial State
    initial begin
        shift_reg = 4'b0000;    // Initialize the shift register to 0
    end

    // Behavior
    always @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000; // Synchronous reset: set register to 0
        end else begin
            shift_reg <= {shift_reg[2:0], in}; // Shift left and insert new bit
        end
    end

    // Output Behavior
    assign out = shift_reg[0]; // LSB of the shift register is the output

endmodule // End of TopModule
```