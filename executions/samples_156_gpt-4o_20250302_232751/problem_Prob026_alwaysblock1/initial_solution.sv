module TopModule (
    input wire a,
    input wire b,
    output wire out_assign,
    output reg out_alwaysblock
);

    // AND operation using assign statement
    assign out_assign = a & b;

    // AND operation using always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule