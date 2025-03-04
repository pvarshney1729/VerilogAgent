module TopModule (
    input wire a,
    input wire b,
    output wire out
);

    // NOR gate implementation
    assign out = ~(a | b);

endmodule