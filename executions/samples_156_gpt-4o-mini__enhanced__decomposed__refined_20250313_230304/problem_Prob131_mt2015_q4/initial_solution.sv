module A (
    input logic x,
    input logic y,
    output logic z
);
    assign z = (x ^ y) & x;
endmodule

module B (
    input logic x,
    input logic y,
    output logic z
);
    always @(*) begin
        case ({x, y})
            2'b00: z = 1;  // Corresponds to times 0ns to 20ns
            2'b10: z = 0;  // Corresponds to times 25ns to 30ns
            2'b01: z = 0;  // Corresponds to times 35ns to 40ns
            2'b11: z = 1;  // Corresponds to times 45ns to 50ns
            default: z = 1; // Corresponds to times 55ns to 90ns
        endcase
    end
endmodule

module TopLevel (
    input logic x,
    input logic y,
    output logic z
);
    logic a1_out, a2_out, b1_out, b2_out;
    logic or_out, and_out;

    A A1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    A A2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    B B1 (
        .x(x),
        .y(y),
        .z(b1_out)
    );

    B B2 (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    assign z = or_out ^ and_out;

endmodule