module ModuleA(
    input logic x,
    input logic y,
    output logic z
);
    always @(*) begin
        z = (x ^ y) & x;
    end
endmodule

module ModuleB(
    input logic x,
    input logic y,
    output logic z
);
    always @(*) begin
        if (x == 0 && y == 0)
            z = 1;
        else if (x == 1 && y == 0)
            z = 0;
        else if (x == 0 && y == 1)
            z = 0;
        else if (x == 1 && y == 1)
            z = 1;
    end
endmodule

module TopModule(
    input logic x,
    input logic y,
    output logic z
);
    logic a1_out, a2_out;
    logic b1_out, b2_out;
    logic or_out, and_out;

    // Instantiate Module A
    ModuleA a1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    ModuleA a2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    // Instantiate Module B
    ModuleB b1 (
        .x(x),
        .y(y),
        .z(b1_out)
    );

    ModuleB b2 (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    // OR gate for the first pair of A and B
    assign or_out = a1_out | b1_out;

    // AND gate for the second pair of A and B
    assign and_out = a2_out & b2_out;

    // XOR gate for the final output
    assign z = or_out ^ and_out;

endmodule