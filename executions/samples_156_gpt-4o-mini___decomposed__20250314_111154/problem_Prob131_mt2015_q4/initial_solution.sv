module A (
    input logic x,
    input logic y,
    output logic z
);
    assign z = (x ^ y) & x;
endmodule

module B (
    input logic x,
    input logic y,
    output logic z
);
    always @(*) begin
        if (x == 0 && y == 0)
            z = 1;
        else if (x == 1 && y == 1)
            z = 1;
        else
            z = 0;
    end
endmodule

module top_level (
    input logic x,
    input logic y,
    output logic z
);
    logic a1_out, a2_out, b1_out, b2_out;
    logic or_out, and_out;

    A u_A1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    B u_B1 (
        .x(x),
        .y(y),
        .z(b1_out)
    );

    A u_A2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    B u_B2 (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    assign z = or_out ^ and_out;
endmodule