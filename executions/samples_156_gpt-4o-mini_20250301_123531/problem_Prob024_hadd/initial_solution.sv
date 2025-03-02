module TopModule (
    input logic a,   // First input bit, unsigned
    input logic b,   // Second input bit, unsigned
    output logic sum, // Sum output bit, unsigned
    output logic cout // Carry-out output bit, unsigned
);

assign sum = a ^ b;   // Sum is the XOR of a and b
assign cout = a & b;  // Carry-out is the AND of a and b

endmodule