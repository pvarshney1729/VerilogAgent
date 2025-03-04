module TopModule(
    input wire a, // 1-bit input, unsigned
    input wire b, // 1-bit input, unsigned
    output wire out_assign, // 1-bit output for assign statement result, unsigned
    output reg out_alwaysblock // 1-bit output for always block result, unsigned
);

    // Continuous assignment for out_assign
    assign out_assign = a & b;

    // Combinational always block for out_alwaysblock
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule