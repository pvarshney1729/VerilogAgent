```verilog
[BEGIN]
module TopModule (
    input logic d,      // 1-bit data input, unsigned
    input logic ena,    // 1-bit enable input, unsigned
    input logic clk,    // 1-bit clock input
    input logic rst,    // 1-bit reset input
    output logic q      // 1-bit data output, unsigned
);

always @(posedge clk) begin
    if (rst) begin
        q <= 1'b0;  // Reset output to 0
    end else if (ena) begin
        q <= d;  // Capture 'd' when 'ena' is high
    end
    // When 'ena' is low and 'rst' is not high, retain the previous value of 'q'
end

endmodule
[DONE]
```