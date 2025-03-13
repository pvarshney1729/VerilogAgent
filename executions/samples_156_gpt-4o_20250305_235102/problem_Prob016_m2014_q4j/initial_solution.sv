```verilog
[BEGIN]
module TopModule (
    input  [3:0] x,
    input  [3:0] y,
    output logic [4:0] sum
);

    logic [3:0] carry;
    logic [3:0] sum_internal;

    always @(*) begin
        carry[0] = x[0] & y[0];
        sum_internal[0] = x[0] ^ y[0];

        carry[1] = (x[1] & y[1]) | (x[1] & carry[0]) | (y[1] & carry[0]);
        sum_internal[1] = x[1] ^ y[1] ^ carry[0];

        carry[2] = (x[2] & y[2]) | (x[2] & carry[1]) | (y[2] & carry[1]);
        sum_internal[2] = x[2] ^ y[2] ^ carry[1];

        carry[3] = (x[3] & y[3]) | (x[3] & carry[2]) | (y[3] & carry[2]);
        sum_internal[3] = x[3] ^ y[3] ^ carry[2];

        sum = {carry[3], sum_internal};
    end

endmodule
[DONE]
```