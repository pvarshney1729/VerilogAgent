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
    assign z = (~x & ~y) | (x & y);
endmodule

module TopModule (
    input logic x,
    input logic y,
    output logic z
);
    logic a1_out, b1_out, a2_out, b2_out;
    logic or_out, and_out;

    // Instantiate the first A and B submodules
    ModuleA a1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    ModuleB b1 (
        .x(x),
        .y(y),
        .z(b1_out)
    );

    // OR gate for the first pair of A and B submodules
    assign or_out = a1_out | b1_out;

    // Instantiate the second A and B submodules
    ModuleA a2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    ModuleB b2 (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    // AND gate for the second pair of A and B submodules
    assign and_out = a2_out & b2_out;

    // XOR gate for the outputs of the OR and AND gates
    assign z = or_out ^ and_out;
endmodule