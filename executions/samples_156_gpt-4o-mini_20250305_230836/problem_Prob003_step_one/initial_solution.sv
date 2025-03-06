```verilog
[BEGIN]
module TopModule(
    output logic one // Output is always logic high
);

always @(*) begin
    one = 1'b1; // Constant logic high
end

endmodule
[DONE]
```