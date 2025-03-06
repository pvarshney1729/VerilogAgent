```verilog
[BEGIN]
module TopModule (
    input  logic        clk,       // Clock signal, active on the negative edge
    input  logic        reset,     // Active high synchronous reset
    input  logic [7:0]  d,         // 8-bit data input, bit[0] is LSB
    output logic [7:0]  q          // 8-bit data output, bit[0] is LSB
);

always @(negedge clk) begin
    if (reset) begin
        q <= 8'b00110100; // Set to 0x34 on reset
    end else begin
        q <= d; // Transfer d to q
    end
end

endmodule
[DONE]
```