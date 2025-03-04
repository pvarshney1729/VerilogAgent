```verilog
module TopModule (
    input logic clk,        // Clock input, triggers on positive edge
    input logic resetn,     // Active-low synchronous reset input
    input logic in,         // Single-bit data input
    output logic out        // Single-bit data output
);

    logic [3:0] shift_reg;  // 4-bit shift register

    always_ff @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000;  // Synchronous reset to 0
        end else begin
            shift_reg <= {shift_reg[2:0], in};  // Shift right and load input
        end
    end

    assign out = shift_reg[3];  // Output the MSB

endmodule
```