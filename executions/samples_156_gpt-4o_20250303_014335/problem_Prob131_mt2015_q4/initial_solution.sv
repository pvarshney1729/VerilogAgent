module ModuleA (
    input logic x,
    input logic y,
    output logic z
);
    assign z = (x ^ y) & x;
endmodule

module ModuleB (
    input logic x,
    input logic y,
    output logic z
);
    assign z = (x & y) | (~x & ~y);
endmodule

module TopModule (
    input logic x,
    input logic y,
    output logic z
);
    logic z_A1, z_A2, z_B1, z_B2;
    logic or_out, and_out;

    ModuleA A1 (
        .x(x),
        .y(y),
        .z(z_A1)
    );

    ModuleA A2 (
        .x(x),
        .y(y),
        .z(z_A2)
    );

    ModuleB B1 (
        .x(x),
        .y(y),
        .z(z_B1)
    );

    ModuleB B2 (
        .x(x),
        .y(y),
        .z(z_B2)
    );

    assign or_out = z_A1 | z_B1;
    assign and_out = z_A2 & z_B2;
    assign z = or_out ^ and_out;
endmodule