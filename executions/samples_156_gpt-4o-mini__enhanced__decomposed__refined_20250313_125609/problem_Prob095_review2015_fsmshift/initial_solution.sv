[BEGIN]
```verilog
module TopModule (
    input logic clk,          // 1-bit clock input, rising edge triggered
    input logic reset,        // 1-bit active high synchronous reset input
    output logic shift_ena    // 1-bit output to enable the shift register
);

    logic [2:0] count; // 3-bit counter to track the number of cycles

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b000;
            shift_ena <= 1'b1; // Assert shift_ena on reset
        end else if (count < 3'b100) begin
            count <= count + 1;
            shift_ena <= 1'b1; // Keep shift_ena asserted for 4 cycles
        end else begin
            shift_ena <= 1'b0; // Deassert shift_ena after 4 cycles
        end
    end

endmodule
```
[DONE]