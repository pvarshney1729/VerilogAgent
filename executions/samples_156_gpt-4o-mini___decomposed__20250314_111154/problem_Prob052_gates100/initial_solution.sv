module TopModule (
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

assign out_and = &in;      // 100-input AND
assign out_or = |in;       // 100-input OR
assign out_xor = ^in;      // 100-input XOR

endmodule