module TopModule(
    input  logic [3:0] x,
    input  logic [3:0] y,
    output logic [4:0] sum
);

    logic c1, c2, c3; // Intermediate carry signals

    // Full adder for bit 0
    always @(*) begin
        sum[0] = x[0] ^ y[0];
        c1 = x[0] & y[0];
    end

    // Full adder for bit 1
    always @(*) begin
        sum[1] = x[1] ^ y[1] ^ c1;
        c2 = (x[1] & y[1]) | (x[1] & c1) | (y[1] & c1);
    end

    // Full adder for bit 2
    always @(*) begin
        sum[2] = x[2] ^ y[2] ^ c2;
        c3 = (x[2] & y[2]) | (x[2] & c2) | (y[2] & c2);
    end

    // Full adder for bit 3
    always @(*) begin
        sum[3] = x[3] ^ y[3] ^ c3;
        sum[4] = (x[3] & y[3]) | (x[3] & c3) | (y[3] & c3);
    end

endmodule