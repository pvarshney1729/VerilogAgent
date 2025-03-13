```
[BEGIN]
module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

logic [7:0] prev_in;

always @(posedge clk) begin
    prev_in <= in;
end

always @(*) begin
    pedge = 8'b00000000; // Default value
    pedge = (prev_in == 8'b00000000) & (in == 8'b00000001) ? 8'b00000001 : pedge;
end

endmodule
[DONE]
```