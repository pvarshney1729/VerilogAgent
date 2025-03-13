```
[BEGIN]
module TopModule (
    input  logic clk,        // Clock signal, active on rising edge
    input  logic areset,     // Asynchronous reset, active high
    input  logic [7:0] d,    // 8-bit data input, unsigned, bit[0] is LSB
    output logic [7:0] q     // 8-bit data output, unsigned, initialized to 0
);

    always @(posedge clk) begin
        if (areset) begin
            q <= 8'b00000000; // Reset output to 0
        end else begin
            q <= d; // Capture input d
        end
    end

endmodule
[DONE]
```