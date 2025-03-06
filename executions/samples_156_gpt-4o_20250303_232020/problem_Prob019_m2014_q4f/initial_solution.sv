module TopModule (
    input wire in1,   // 1-bit input, standard logic level
    input wire in2,   // 1-bit input, standard logic level
    output wire out   // 1-bit output, standard logic level
);

    assign out = in1 & ~in2; // AND gate with inverted in2 input

endmodule