[BEGIN]
```verilog
module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic [7:0] c,
    input logic [7:0] d,
    output logic [7:0] min
);

    always @(*) begin
        min = 8'hFF; // Initialize min to maximum value
        if (a < min) min = a;
        if (b < min) min = b;
        if (c < min) min = c;
        if (d < min) min = d;
    end

endmodule
```
[DONE]