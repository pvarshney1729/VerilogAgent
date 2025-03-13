```
[BEGIN]
module TopModule (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [7:0] c,
    input  logic [7:0] d,
    output logic [7:0] min
);
    always @(*) begin
        if (a < b) begin
            if (a < c) begin
                min = (a < d) ? a : d;
            end else begin
                min = (c < d) ? c : d;
            end
        end else begin
            if (b < c) begin
                min = (b < d) ? b : d;
            end else begin
                min = (c < d) ? c : d;
            end
        end
    end
endmodule
[DONE]
```