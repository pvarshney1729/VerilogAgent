```
[BEGIN]
module TopModule (
    input logic [3:0] in,
    output logic [1:0] pos
);
    always_comb begin
        if (in[3]) 
            pos = 2'b11;  // in[3] is high
        else if (in[2]) 
            pos = 2'b10;  // in[2] is high
        else if (in[1]) 
            pos = 2'b01;  // in[1] is high
        else 
            pos = 2'b00;  // no high bits
    end
endmodule
[DONE]
```