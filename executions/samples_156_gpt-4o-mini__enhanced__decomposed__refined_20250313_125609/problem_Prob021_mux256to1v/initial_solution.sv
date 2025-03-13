```
[BEGIN]
module TopModule (
    input  logic [1023:0] in,    // 1024-bit wide input vector
    input  logic [7:0]   sel,    // 8-bit selector (0 to 255)
    output logic [3:0]   out     // 4-bit output
);

always @(*) begin
    out = 4'b0000; // Initial state for combinational logic
    if (sel < 8'd256) begin
        out = in[sel * 4 +: 4]; // Select 4 bits starting from index sel*4
    end else begin
        out = 4'b0000; // Keep the output unchanged if out of range
    end
end

endmodule
[DONE]
```