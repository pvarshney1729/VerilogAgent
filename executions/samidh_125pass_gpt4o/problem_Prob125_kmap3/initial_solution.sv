module TopModule (
    input logic a,  // 1-bit, unsigned
    input logic b,  // 1-bit, unsigned
    input logic c,  // 1-bit, unsigned
    input logic d,  // 1-bit, unsigned (don't-care condition)
    output logic out // 1-bit, unsigned
);

    // Combinational logic derived from the Karnaugh map
    always_comb begin
        out = (~a & b & ~c) | (~a & ~b & c) | (~a & b & c) | (a & c);
    end

endmodule