```
[BEGIN]
module TopModule(
    input logic [2:0] vec,
    output logic [2:0] outv,
    output logic o2,
    output logic o1,
    output logic o0
);

    always @(*) begin
        outv = vec;         // Directly assign the input vector to the output vector
        o2 = vec[2];       // Assign each bit of the input vector to the corresponding output
        o1 = vec[1];
        o0 = vec[0];
    end

endmodule
[DONE]
```