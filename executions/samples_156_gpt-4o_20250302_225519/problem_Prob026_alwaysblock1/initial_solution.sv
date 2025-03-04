module TopModule (
    input wire a,
    input wire b,
    output wire out_assign,
    output reg out_alwaysblock
);

    // Continuous assignment for out_assign
    assign out_assign = a & b;

    // Combinational always block for out_alwaysblock
    always @* begin
        out_alwaysblock = a & b;
    end

endmodule