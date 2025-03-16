```verilog
module TopModule (
    input  [7:0] a,
    input  [7:0] b,
    input  [7:0] c,
    input  [7:0] d,
    output reg [7:0] min_value
);
    always @(*) begin
        reg [7:0] temp_min;
        
        // Initial comparison among a, b, and c
        if (a <= b && a <= c) begin
            temp_min = a;
        end else if (b <= a && b <= c) begin
            temp_min = b;
        end else begin
            temp_min = c;
        end
        
        // Compare result of previous comparison with d
        if (d < temp_min) begin
            temp_min = d;
        end
        
        min_value = temp_min;
    end
endmodule
```