```verilog
[BEGIN]
module TopModule(
    input [3:0] x,
    output logic f
);

always @(*) begin
    case (x)
        4'b0100: f = 1'b1;
        4'b0111: f = 1'b1;
        4'b1000: f = 1'b1;
        4'b1001: f = 1'b1;
        default: f = 1'b0;
    endcase
end

endmodule
[DONE]
```