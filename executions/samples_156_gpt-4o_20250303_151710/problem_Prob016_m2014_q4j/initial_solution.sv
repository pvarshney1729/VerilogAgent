```verilog
module TopModule(
    input  [3:0] input_x,
    input  [3:0] input_y,
    output [4:0] sum
);

    logic [3:0] carry;

    // Full Adder for bit 0
    assign sum[0] = input_x[0] ^ input_y[0];
    assign carry[0] = input_x[0] & input_y[0];

    // Full Adder for bit 1
    assign sum[1] = input_x[1] ^ input_y[1] ^ carry[0];
    assign carry[1] = (input_x[1] & input_y[1]) | (carry[0] & (input_x[1] ^ input_y[1]));

    // Full Adder for bit 2
    assign sum[2] = input_x[2] ^ input_y[2] ^ carry[1];
    assign carry[2] = (input_x[2] & input_y[2]) | (carry[1] & (input_x[2] ^ input_y[2]));

    // Full Adder for bit 3
    assign sum[3] = input_x[3] ^ input_y[3] ^ carry[2];
    assign carry[3] = (input_x[3] & input_y[3]) | (carry[2] & (input_x[3] ^ input_y[3]));

    // Overflow bit
    assign sum[4] = carry[3];

endmodule
```