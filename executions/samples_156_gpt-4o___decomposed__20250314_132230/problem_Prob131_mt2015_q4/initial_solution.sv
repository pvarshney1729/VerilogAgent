module top_module (
    input  logic x,
    input  logic y,
    output logic z
);

    logic a1_out, a2_out, b1_out, b2_out;
    logic or_out, and_out;

    // Module A: z = (x ^ y) & x
    module A (
        input  logic x,
        input  logic y,
        output logic z
    );
        assign z = (x ^ y) & x;
    endmodule

    // Module B: Based on the waveform, z = ~(x | y)
    module B (
        input  logic x,
        input  logic y,
        output logic z
    );
        assign z = ~(x | y);
    endmodule

    // Instantiate modules
    A module_a1 (.x(x), .y(y), .z(a1_out));
    A module_a2 (.x(x), .y(y), .z(a2_out));
    B module_b1 (.x(x), .y(y), .z(b1_out));
    B module_b2 (.x(x), .y(y), .z(b2_out));

    // Logic connections
    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    assign z = or_out ^ and_out;

endmodule