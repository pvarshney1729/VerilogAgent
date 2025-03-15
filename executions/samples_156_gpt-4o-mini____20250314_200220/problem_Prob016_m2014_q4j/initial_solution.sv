module TopModule (
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [4:0] sum
);

    logic [3:0] carry;

    always @(*) begin
        {carry[0], sum[0]} = x[0] + y[0];
        {carry[1], sum[1]} = x[1] + y[1] + carry[0];
        {carry[2], sum[2]} = x[2] + y[2] + carry[1];
        {carry[3], sum[3]} = x[3] + y[3] + carry[2];
        sum[4] = carry[3]; // Overflow bit
    end

endmodule