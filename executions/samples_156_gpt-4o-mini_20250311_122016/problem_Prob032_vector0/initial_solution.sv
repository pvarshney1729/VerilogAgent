```
[BEGIN]
module TopModule(
    input  logic [2:0] vec,
    output logic [2:0] outv,
    output logic o0,
    output logic o1,
    output logic o2
);

always @(*) begin
    outv = vec;
    o0 = vec[0]; // 1'b0 not needed for assignment since vec[0] is already a logic type
    o1 = vec[1]; // 1'b0 not needed for assignment since vec[1] is already a logic type
    o2 = vec[2]; // 1'b0 not needed for assignment since vec[2] is already a logic type
end

endmodule
[DONE]
```