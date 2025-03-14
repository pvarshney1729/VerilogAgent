[BEGIN]
module TopModule(
    input logic [3:0] x,  // 4-bit input
    input logic [3:0] y,  // 4-bit input
    output logic [4:0] sum // 5-bit output
);
    logic [3:0] carry; // Internal logic for carry propagation

    always @(*) begin
        // Full adder for bit 0
        {carry[0], sum[0]} = x[0] + y[0] + 1'b0;

        // Full adder for bit 1
        {carry[1], sum[1]} = x[1] + y[1] + carry[0];

        // Full adder for bit 2
        {carry[2], sum[2]} = x[2] + y[2] + carry[1];

        // Full adder for bit 3
        {sum[4], sum[3]} = x[3] + y[3] + carry[2];
    end

    // sum[4] is the overflow bit
endmodule
[END]