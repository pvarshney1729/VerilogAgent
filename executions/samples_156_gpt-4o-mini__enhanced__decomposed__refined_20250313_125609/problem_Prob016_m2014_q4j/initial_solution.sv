```verilog
[BEGIN]
module TopModule (
    input  logic [3:0] x,      
    input  logic [3:0] y,      
    output logic [4:0] sum     
);

    logic c0, c1, c2; // Carry signals
    logic s0, s1, s2, s3; // Sum bits

    always @(*) begin
        // Full adder for LSB (x[0], y[0], Cin = 1'b0)
        s0 = x[0] ^ y[0];
        c0 = x[0] & y[0];

        // Full adder for bit 1 (x[1], y[1], Cin = c0)
        s1 = x[1] ^ y[1] ^ c0;
        c1 = (x[1] & y[1]) | (c0 & (x[1] ^ y[1]));

        // Full adder for bit 2 (x[2], y[2], Cin = c1)
        s2 = x[2] ^ y[2] ^ c1;
        c2 = (x[2] & y[2]) | (c1 & (x[2] ^ y[2]));

        // Full adder for MSB (x[3], y[3], Cin = c2)
        s3 = x[3] ^ y[3] ^ c2;
        sum[4] = (x[3] & y[3]) | (c2 & (x[3] ^ y[3])); // Overflow bit
        sum[3:0] = {s3, s2, s1, s0}; // Concatenate sum bits
    end

endmodule
[DONE]
```