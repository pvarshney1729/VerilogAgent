module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);
    assign out = in1 & ~in2; // AND gate with bubbled in2
endmodule