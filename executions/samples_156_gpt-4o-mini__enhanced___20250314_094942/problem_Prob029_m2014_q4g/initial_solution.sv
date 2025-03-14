module TopModule (
    input logic in1,  // One-bit input
    input logic in2,  // One-bit input
    input logic in3,  // One-bit input
    output logic out  // One-bit output
);

    assign out = (in1 ~^ in2) ^ in3;

endmodule