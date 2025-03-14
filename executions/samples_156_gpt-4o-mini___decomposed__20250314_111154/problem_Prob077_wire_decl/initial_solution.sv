module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out,
    output logic out_n
);

logic and1_out;  // Intermediate wire for first AND gate
logic and2_out;  // Intermediate wire for second AND gate

assign and1_out = a & b;  // First AND gate
assign and2_out = c & d;  // Second AND gate
assign out = and1_out | and2_out;  // OR gate
assign out_n = ~out;  // NOT gate

endmodule