module TopModule (
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [4:0] sum
);

    logic c0, c1, c2, c3;

    // Full Adder for bit 0
    assign {c0, sum[0]} = x[0] + y[0];

    // Full Adder for bit 1
    assign {c1, sum[1]} = x[1] + y[1] + c0;

    // Full Adder for bit 2
    assign {c2, sum[2]} = x[2] + y[2] + c1;

    // Full Adder for bit 3
    assign {c3, sum[3]} = x[3] + y[3] + c2;

    // Overflow bit
    assign sum[4] = c3;

endmodule