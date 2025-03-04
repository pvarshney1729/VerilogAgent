module TopModule (
    input logic a,  // Unsigned, single-bit
    input logic b,  // Unsigned, single-bit
    input logic c,  // Unsigned, single-bit
    input logic d,  // Unsigned, single-bit
    output logic out // Unsigned, single-bit
);

    // Combinational logic derived from the Karnaugh map
    always @(*) begin
        out = (~c & ~d) | (c & d & ~a) | (c & d & ~b) | (c & ~d & a) | (c & ~d & b);
    end

endmodule