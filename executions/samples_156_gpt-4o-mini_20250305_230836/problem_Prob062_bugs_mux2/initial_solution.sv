```verilog
[BEGIN]
module TopModule (
    input        sel,     // 1-bit selection signal
    input  logic [7:0] a, // 8-bit input bus 'a'
    input  logic [7:0] b, // 8-bit input bus 'b'
    output logic [7:0] out // 8-bit output bus for the mux result
);

always @(*) begin
    out = sel ? b : a;
end

endmodule
[DONE]
```