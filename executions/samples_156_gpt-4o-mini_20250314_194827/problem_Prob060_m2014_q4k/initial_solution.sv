```verilog
module TopModule (
    input logic clk,       // Clock signal, positive-edge triggered
    input logic resetn,    // Active-low synchronous reset
    input logic in,        // Serial input to the shift register
    output logic out       // Output from the shift register (MSB)
);

logic [3:0] shift_reg;  // 4-bit shift register

always @(posedge clk) begin
    if (!resetn) begin
        shift_reg <= 4'b0000;  // Reset state
    end else begin
        shift_reg <= {shift_reg[2:0], in};  // Shift operation
    end
end

assign out = shift_reg[3];  // MSB of the shift register
```