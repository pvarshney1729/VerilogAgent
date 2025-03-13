module TopModule(
    input logic a,
    input logic b,
    input logic cin,
    output logic cout,
    output logic sum
);

assign sum = a ^ b ^ cin; // XOR operation for sum
assign cout = (a & b) | (b & cin) | (a & cin); // OR of ANDs for carry-out

endmodule