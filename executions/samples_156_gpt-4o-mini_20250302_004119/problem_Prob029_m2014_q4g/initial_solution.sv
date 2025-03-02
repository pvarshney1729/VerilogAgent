module TopModule (
    input logic in1,  // 1-bit, unsigned
    input logic in2,  // 1-bit, unsigned
    input logic in3,  // 1-bit, unsigned
    output logic out   // 1-bit, unsigned
);

assign out = (in1 ~^ in2) ^ in3;

endmodule