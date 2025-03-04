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
    assign z = (x == 1'b0 && y == 1'b0) ? 1'b1 :
                (x == 1'b1 && y == 1'b0) ? 1'b0 :
                (x == 1'b0 && y == 1'b1) ? 1'b0 :
                (x == 1'b1 && y == 1'b1) ? 1'b1 : 1'b0;
endmodule

module TopLevel (
    input logic x,
    input logic y,
    output logic z
);
    logic z_A1, z_A2, z_B1, z_B2;
    logic or_output, and_output;

    ModuleA instA1 (.x(x), .y(y), .z(z_A1));
    ModuleB instB1 (.x(x), .y(y), .z(z_B1));
    ModuleA instA2 (.x(x), .y(y), .z(z_A2));
    ModuleB instB2 (.x(x), .y(y), .z(z_B2));

    assign or_output = z_A1 | z_B1;
    assign and_output = z_A2 & z_B2;
    assign z = or_output ^ and_output;
endmodule