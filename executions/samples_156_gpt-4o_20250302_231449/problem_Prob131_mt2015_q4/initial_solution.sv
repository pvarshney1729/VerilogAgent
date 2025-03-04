module ModuleA (
    input logic x,
    input logic y,
    output logic z
);
    always @(*) begin
        z = (x ^ y) & x;
    end
endmodule

module ModuleB (
    input logic x,
    input logic y,
    output logic z
);
    always @(*) begin
        case ({x, y})
            2'b00: z = 1'b1;
            2'b01: z = 1'b0;
            2'b10: z = 1'b0;
            2'b11: z = 1'b1;
            default: z = 1'b0; // Default case for safety
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

    ModuleA A1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    ModuleB B1 (
        .x(x),
        .y(y),
        .z(b1_out)
    );

    ModuleA A2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    ModuleB B2 (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    always @(*) begin
        or_out = a1_out | b1_out;
        and_out = a2_out & b2_out;
        z = or_out ^ and_out;
    end
endmodule