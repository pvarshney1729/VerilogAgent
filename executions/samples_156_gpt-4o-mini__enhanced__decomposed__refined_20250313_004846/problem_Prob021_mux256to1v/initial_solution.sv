```verilog
module TopModule (
    input  logic [1023:0] in,  // 1024-bit input vector containing 256 4-bit words
    input  logic [7:0]    sel, // 8-bit selection input, selects one of the 256 4-bit words
    output logic [3:0]    out  // 4-bit output corresponding to the selected word
);

always @(*) begin
    if (sel <= 8'd255) begin
        out = in[sel*4 +: 4]; // Selects the corresponding 4-bit slice
    end else begin
        out = 4'b0000; // Default output for invalid `sel`
    end
end

endmodule
```