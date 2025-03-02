```verilog
module TopModule (
    input logic [255:0] in,  // 256-bit input vector, in[0] is LSB and in[255] is MSB
    input logic [7:0] sel,   // 8-bit selection input
    output logic out         // 1-bit output
);

    always @(*) begin
        if (sel <= 8'd255) begin
            out = in[sel];
        end else begin
            out = 1'bx; // Undefined behavior for sel > 255
        end
    end

endmodule
```