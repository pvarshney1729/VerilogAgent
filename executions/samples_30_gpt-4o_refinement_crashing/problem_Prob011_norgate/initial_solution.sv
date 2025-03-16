module TopModule(
    input  a,
    input  b,
    output out
);

    // Implementing the NOR gate logic
    assign out = ~(a | b);

endmodule