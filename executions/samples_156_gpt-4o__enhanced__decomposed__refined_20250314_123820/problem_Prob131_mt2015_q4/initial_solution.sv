module TopLevelModule(
    input logic x,
    input logic y,
    output logic z
);

    logic z_A1, z_B1, z_A2, z_B2;
    logic or_output, and_output;

    // Instantiate two Module A instances
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

    // Instantiate two Module B instances
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

    // OR gate for the first pair of Module A and B
    assign or_output = z_A1 | z_B1;

    // AND gate for the second pair of Module A and B
    assign and_output = z_A2 & z_B2;

    // XOR gate for the final output
    assign z = or_output ^ and_output;

endmodule

module ModuleA(
    input logic x,
    input logic y,
    output logic z
);
    assign z = (x ^ y) & x;
endmodule

module ModuleB(
    input logic x,
    input logic y,
    output logic z
);
    // Implementing the behavior of Module B based on the waveform
    always_comb begin
        case ({x, y})
            2'b00: z = 1'b1;
            2'b01: z = 1'b0;
            2'b10: z = 1'b0;
            2'b11: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule