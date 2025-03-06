```verilog
module TopModule (
    input  logic [3:0] x,  // 4-bit unsigned input
    input  logic [3:0] y,  // 4-bit unsigned input
    output logic [4:0] sum // 5-bit unsigned output, including overflow
);

    logic c1, c2, c3; // carry bits

    always @(*) begin
        // Full adder for bit 0
        sum[0] = x[0] ^ y[0]; // sum bit 0
        c1 = x[0] & y[0]; // carry out from bit 0

        // Full adder for bit 1
        sum[1] = x[1] ^ y[1] ^ c1; // sum bit 1
        c2 = (x[1] & y[1]) | (c1 & (x[1] ^ y[1])); // carry out from bit 1

        // Full adder for bit 2
        sum[2] = x[2] ^ y[2] ^ c2; // sum bit 2
        c3 = (x[2] & y[2]) | (c2 & (x[2] ^ y[2])); // carry out from bit 2

        // Full adder for bit 3
        sum[3] = x[3] ^ y[3] ^ c3; // sum bit 3
        sum[4] = (x[3] & y[3]) | (c3 & (x[3] ^ y[3])); // overflow bit
    end

endmodule
```