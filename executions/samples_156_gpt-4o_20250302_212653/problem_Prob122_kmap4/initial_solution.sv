module TopModule(
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out
);

    // Combinational logic derived from the Karnaugh map
    assign out = (!c & b) | (c & !b);

endmodule