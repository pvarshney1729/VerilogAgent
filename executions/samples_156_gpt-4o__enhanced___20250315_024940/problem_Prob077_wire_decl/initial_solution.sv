module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out,
    output logic out_n
);

    logic and_output1;
    logic and_output2;

    // First layer: two AND gates
    assign and_output1 = a & b; // AND gate for inputs a and b
    assign and_output2 = c & d; // AND gate for inputs c and d

    // Second layer: OR gate
    assign out = and_output1 | and_output2; // OR gate for the outputs of the AND gates

    // Inverted output
    assign out_n = ~out; // NOT gate for output out

endmodule