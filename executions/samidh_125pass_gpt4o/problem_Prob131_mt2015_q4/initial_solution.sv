module ModuleA (
    input logic [0:0] x,
    input logic [0:0] y,
    output logic [0:0] z
);
    assign z = (x ^ y) & x;
endmodule

module ModuleB (
    input logic [0:0] x,
    input logic [0:0] y,
    output logic [0:0] z
);
    always_comb begin
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
    input logic [0:0] x,
    input logic [0:0] y,
    output logic [0:0] z
);
    logic [0:0] a1_out, a2_out, b1_out, b2_out;
    logic [0:0] or_out, and_out;

    ModuleA a1 (.x(x), .y(y), .z(a1_out));
    ModuleA a2 (.x(x), .y(y), .z(a2_out));
    ModuleB b1 (.x(x), .y(y), .z(b1_out));
    ModuleB b2 (.x(x), .y(y), .z(b2_out));

    assign or_out = a1_out | b1_out;
    assign and_out = a2_out & b2_out;
    assign z = or_out ^ and_out;
endmodule