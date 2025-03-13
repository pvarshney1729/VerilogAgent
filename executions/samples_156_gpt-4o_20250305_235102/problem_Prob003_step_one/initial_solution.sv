```verilog
[BEGIN]
module TopModule (
    output logic high_signal
);

always @(*) begin
    high_signal = 1'b1;
end

endmodule
[DONE]
```