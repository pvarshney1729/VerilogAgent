```
[BEGIN]
module TopModule (
    input  logic [2:0] in,  // 3-bit input vector
    output logic [1:0] out  // 2-bit output vector representing population count
);

    always @(*) begin
        out = 2'b00; // Initialize output
        out = (in[2] ? 2'b01 : 2'b00) + 
              (in[1] ? 2'b01 : 2'b00) + 
              (in[0] ? 2'b01 : 2'b00);
    end

endmodule
[DONE]
```