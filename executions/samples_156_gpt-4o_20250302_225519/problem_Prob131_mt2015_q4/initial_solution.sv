module ModuleA (
    input wire x,
    input wire y,
    output wire z_A
);
    assign z_A = (x ^ y) & x;
endmodule

module ModuleB (
    input wire x,
    input wire y,
    output wire z_B
);
    assign z_B = (x & y) | (~x & ~y);
endmodule

module TopLevel (
    input wire x,
    input wire y,
    output wire z
);
    wire z_A1, z_A2, z_B1, z_B2;
    wire or_out, and_out;

    // Instantiate Module A
    ModuleA A1 (
        .x(x),
        .y(y),
        .z_A(z_A1)
    );

    ModuleA A2 (
        .x(x),
        .y(y),
        .z_A(z_A2)
    );

    // Instantiate Module B
    ModuleB B1 (
        .x(x),
        .y(y),
        .z_B(z_B1)
    );

    ModuleB B2 (
        .x(x),
        .y(y),
        .z_B(z_B2)
    );

    // OR gate
    assign or_out = z_A1 | z_B1;

    // AND gate
    assign and_out = z_A2 & z_B2;

    // XOR gate
    assign z = or_out ^ and_out;
endmodule