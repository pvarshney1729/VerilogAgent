module TopModule (
    input wire a,
    input wire b,
    input wire c,
    output wire out
);

    // Combinational logic for output
    assign out = a | (b & c);

endmodule