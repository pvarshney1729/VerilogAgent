```verilog
module TopModule(
    input logic clk,
    input logic resetn,
    input logic in,
    output logic out
);
    logic [3:0] shift_reg; // 4-bit shift register

    always @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000; // Reset state
        end else begin
            shift_reg <= {in, shift_reg[3:1]}; // Shift right
        end
        out <= shift_reg[0]; // Output the LSB
    end
endmodule
```