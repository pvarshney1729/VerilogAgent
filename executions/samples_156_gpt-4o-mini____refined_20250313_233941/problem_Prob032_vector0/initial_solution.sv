[BEGIN]
```verilog
module TopModule (
    input logic [2:0] vec,
    output logic [2:0] outv,
    output logic o2,
    output logic o1,
    output logic o0
);

    always @(*) begin
        outv = vec;
        o0 = vec[0]; // 1'b0
        o1 = vec[1]; // 1'b1
        o2 = vec[2]; // 1'b2
    end

endmodule
```
[DONE]