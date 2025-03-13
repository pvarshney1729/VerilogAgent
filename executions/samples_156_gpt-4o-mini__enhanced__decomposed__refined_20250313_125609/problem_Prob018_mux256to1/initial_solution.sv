```verilog
module TopModule (
    input logic [255:0] in,     // 256-bit input vector, in[0] is the least significant bit (LSB)
    input logic [7:0] sel,      // 8-bit select signal
    output logic out            // 1-bit output
);

always @(*) begin
    if (sel < 8'd256) begin
        out = in[sel];          // Select the appropriate bit from 'in'
    end else begin
        out = 1'b0;             // Default case for out of range
    end
end

endmodule
```