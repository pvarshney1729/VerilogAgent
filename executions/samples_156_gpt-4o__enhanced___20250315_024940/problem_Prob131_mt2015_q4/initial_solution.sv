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
        if (x == 0 && y == 0) begin
            z = 1;
        end else if (x == 1 && y == 0) begin
            z = 0;
        end else if (x == 0 && y == 1) begin
            z = 0;
        end else if (x == 1 && y == 1) begin
            z = 1;
        end
    end
endmodule

module TopModule (
    input logic x,
    input logic y,
    output logic z
);
    logic z_a1, z_b1, z_a2, z_b2;
    logic or_out, and_out;

    A a1 (
        .x(x),
        .y(y),
        .z(z_a1)
    );

    B b1 (
        .x(x),
        .y(y),
        .z(z_b1)
    );

    A a2 (
        .x(x),
        .y(y),
        .z(z_a2)
    );

    B b2 (
        .x(x),
        .y(y),
        .z(z_b2)
    );

    assign or_out = z_a1 | z_b1;
    assign and_out = z_a2 & z_b2;

    assign z = or_out ^ and_out;
endmodule