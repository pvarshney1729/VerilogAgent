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
    assign z = (x == 0 && y == 0) ? 1 :
               (x == 1 && y == 0) ? 0 :
               (x == 0 && y == 1) ? 0 :
               (x == 1 && y == 1) ? 1 : 1; // Default case
endmodule

module TopLevel (
    input logic x,
    input logic y,
    output logic z
);
    logic z_a1, z_a2, z_b1, z_b2;
    logic or_out, and_out;

    ModuleA a1 (.x(x), .y(y), .z(z_a1));
    ModuleB b1 (.x(x), .y(y), .z(z_b1));
    ModuleA a2 (.x(x), .y(y), .z(z_a2));
    ModuleB b2 (.x(x), .y(y), .z(z_b2));

    assign or_out = z_a1 | z_b1;
    assign and_out = z_a2 & z_b2;
    assign z = or_out ^ and_out;
endmodule