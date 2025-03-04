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
    // Assuming Module B is a simple combinational logic for demonstration
    assign z = x & y; // Example logic, replace with actual specification if different
endmodule

module TopLevel (
    input logic x,
    input logic y,
    output logic z
);
    logic A1_z, A2_z, B1_z, B2_z;
    logic or_gate_out, and_gate_out;

    ModuleA A1 (
        .x(x),
        .y(y),
        .z(A1_z)
    );

    ModuleA A2 (
        .x(x),
        .y(y),
        .z(A2_z)
    );

    ModuleB B1 (
        .x(x),
        .y(y),
        .z(B1_z)
    );

    ModuleB B2 (
        .x(x),
        .y(y),
        .z(B2_z)
    );

    assign or_gate_out = A1_z | B1_z;
    assign and_gate_out = A2_z & B2_z;
    assign z = or_gate_out ^ and_gate_out;
endmodule