```verilog
module TopModule (
    input logic clk,           // Clock signal, active on the rising edge
    input logic resetn,        // Active-low synchronous reset
    input logic data_in,       // 1-bit input data to be shifted into the register
    output logic data_out      // 1-bit output of the shift register
);

    logic [3:0] shift_reg;     // 4-bit shift register

    always_ff @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000; // Clear shift register on reset
        end else begin
            shift_reg <= {shift_reg[2:0], data_in}; // Shift left
        end
    end

    assign data_out = shift_reg[3]; // Output the MSB

endmodule
```