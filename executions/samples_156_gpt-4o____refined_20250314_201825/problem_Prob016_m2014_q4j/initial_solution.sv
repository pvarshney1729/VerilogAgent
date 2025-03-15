module TopModule (
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [4:0] sum
);

    logic [3:0] carry;

    // Full adder for bit 0
    always @(*) begin
        sum[0] = x[0] ^ y[0];
        carry[0] = x[0] & y[0];
    end

    // Full adder for bit 1
    always @(*) begin
        sum[1] = x[1] ^ y[1] ^ carry[0];
        carry[1] = (x[1] & y[1]) | (x[1] & carry[0]) | (y[1] & carry[0]);
    end

    // Full adder for bit 2
    always @(*) begin
        sum[2] = x[2] ^ y[2] ^ carry[1];
        carry[2] = (x[2] & y[2]) | (x[2] & carry[1]) | (y[2] & carry[1]);
    end

    // Full adder for bit 3
    always @(*) begin
        sum[3] = x[3] ^ y[3] ^ carry[2];
        carry[3] = (x[3] & y[3]) | (x[3] & carry[2]) | (y[3] & carry[2]);
    end

    // Overflow bit
    always @(*) begin
        sum[4] = carry[3];
    end

endmodule