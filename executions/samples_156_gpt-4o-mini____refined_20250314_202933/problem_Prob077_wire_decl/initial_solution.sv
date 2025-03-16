[BEGIN]
```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out,
    output logic out_n
);

    logic and1_out;
    logic and2_out;

    always @(*) begin
        and1_out = a & b; 
        and2_out = c & d; 
        out = and1_out | and2_out;
        out_n = ~out; // out_n = 1'b0 if out = 1'b1 and vice versa
    end

endmodule
```
[DONE]