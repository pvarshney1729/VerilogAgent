module TopModule (
    input logic a, // Unsigned 1-bit input
    input logic b, // Unsigned 1-bit input
    input logic c, // Unsigned 1-bit input
    input logic d, // Unsigned 1-bit input
    output logic out // Unsigned 1-bit output
);

    // Combinational logic derived from the Karnaugh map
    always @(*) begin
        out = (!c & !d) | (!c & b) | (c & d & b) | (c & !d & !a);
    end

endmodule