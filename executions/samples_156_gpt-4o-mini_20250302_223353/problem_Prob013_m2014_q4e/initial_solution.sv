module TopModule (
    input logic in1,  // 1-bit unsigned input
    input logic in2,  // 1-bit unsigned input
    output logic out  // 1-bit unsigned output
);

assign out = ~(in1 | in2); // Implementing the NOR gate

endmodule