module A(
    input logic x,
    input logic y,
    output logic z
);
    always @(*) begin
        z = (x ^ y) & x;
    end
endmodule

module B(
    input logic x,
    input logic y,
    output logic z
);
    always @(*) begin
        z = ~(x ^ y);
    end
endmodule

module TopModule(
    input logic x,
    input logic y,
    output logic z
);
    logic a1_out, a2_out, b1_out, b2_out;
    logic or_out, and_out;

    // Instantiate first A and B submodules
    A a1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    B b1 (
        .x(x),
        .y(y),
        .z(b1_out)
    );

    // Instantiate second A and B submodules
    A a2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    B b2 (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    // OR gate for first pair of submodules
    always @(*) begin
        or_out = a1_out | b1_out;
    end

    // AND gate for second pair of submodules
    always @(*) begin
        and_out = a2_out & b2_out;
    end

    // XOR gate for final output
    always @(*) begin
        z = or_out ^ and_out;
    end
endmodule