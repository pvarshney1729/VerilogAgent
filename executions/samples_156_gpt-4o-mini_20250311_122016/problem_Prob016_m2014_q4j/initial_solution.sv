```verilog
[BEGIN]
module TopModule (
    input logic [3:0] x,        // 4-bit unsigned input, with x[3] as MSB and x[0] as LSB
    input logic [3:0] y,        // 4-bit unsigned input, with y[3] as MSB and y[0] as LSB
    output logic [4:0] sum      // 5-bit unsigned output to accommodate overflow, with sum[4] as carry-out
);

    logic c1, c2, c3;

    always @(*) begin
        // Full adder for bit 0
        {c1, sum[0]} = x[0] + y[0];

        // Full adder for bit 1
        {c2, sum[1]} = x[1] + y[1] + c1;

        // Full adder for bit 2
        {c3, sum[2]} = x[2] + y[2] + c2;

        // Full adder for bit 3
        {sum[4], sum[3]} = x[3] + y[3] + c3; // carry out
    end

endmodule
[DONE]
```