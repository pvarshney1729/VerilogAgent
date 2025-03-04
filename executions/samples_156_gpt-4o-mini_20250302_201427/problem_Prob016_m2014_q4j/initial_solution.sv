module TopModule (
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [4:0] sum
);

    logic c0, c1, c2; // carry bits

    // Full adder for bit 0
    assign sum[0] = x[0] ^ y[0];
    assign c0 = x[0] & y[0];

    // Full adder for bit 1
    assign sum[1] = x[1] ^ y[1] ^ c0;
    assign c1 = (x[1] & y[1]) | (c0 & (x[1] ^ y[1]));

    // Full adder for bit 2
    assign sum[2] = x[2] ^ y[2] ^ c1;
    assign c2 = (x[2] & y[2]) | (c1 & (x[2] ^ y[2]));

    // Full adder for bit 3
    assign sum[3] = x[3] ^ y[3] ^ c2;
    assign sum[4] = (x[3] & y[3]) | (c2 & (x[3] ^ y[3]));

endmodule