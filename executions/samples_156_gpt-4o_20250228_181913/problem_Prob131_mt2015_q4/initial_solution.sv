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
    input logic clk,
    input logic rst,
    output logic z
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            z <= 1'b1;
        end else begin
            z <= (~x & ~y) | (x & y);
        end
    end
endmodule

module TopLevel (
    input logic x,
    input logic y,
    input logic clk,
    input logic rst,
    output logic z
);
    logic a1_out, a2_out, b1_out, b2_out;
    logic or_out, and_out;

    ModuleA u1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );

    ModuleB u2 (
        .x(x),
        .y(y),
        .clk(clk),
        .rst(rst),
        .z(b1_out)
    );

    ModuleA u3 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    ModuleB u4 (
        .x(x),
        .y(y),
        .clk(clk),
        .rst(rst),
        .z(b2_out)
    );

    always @(*) begin
        or_out = a1_out | b1_out;
        and_out = a2_out & b2_out;
        z = or_out ^ and_out;
    end
endmodule