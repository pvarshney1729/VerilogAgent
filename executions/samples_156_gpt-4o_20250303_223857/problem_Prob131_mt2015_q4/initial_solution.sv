module ModuleA (
    input logic [0:0] x, y,
    output logic [0:0] z
);
    always @(*) begin
        z = (x ^ y) & x;
    end
endmodule

module ModuleB (
    input logic clk,
    input logic [0:0] x, y,
    output logic [0:0] z
);
    always_ff @(posedge clk) begin
        if (x == 0 && y == 0)
            z <= 1'b1;
        else if (x == 1 && y == 0)
            z <= 1'b0;
        else if (x == 0 && y == 1)
            z <= 1'b0;
        else if (x == 1 && y == 1)
            z <= 1'b1;
    end
endmodule

module TopLevel (
    input logic clk,
    input logic [0:0] x, y,
    output logic [0:0] z
);
    logic [0:0] zA1, zB1, zA2, zB2;
    logic [0:0] or_out, and_out;

    ModuleA u1_ModuleA (
        .x(x),
        .y(y),
        .z(zA1)
    );

    ModuleB u1_ModuleB (
        .clk(clk),
        .x(x),
        .y(y),
        .z(zB1)
    );

    ModuleA u2_ModuleA (
        .x(x),
        .y(y),
        .z(zA2)
    );

    ModuleB u2_ModuleB (
        .clk(clk),
        .x(x),
        .y(y),
        .z(zB2)
    );

    always @(*) begin
        or_out = zA1 | zB1;
        and_out = zA2 & zB2;
        z = or_out ^ and_out;
    end
endmodule