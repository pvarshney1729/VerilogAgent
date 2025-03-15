module TopModule(
    input logic a,
    input logic b,
    input logic cin,
    output logic cout,
    output logic sum
);
    // Combinational logic for full adder
    assign sum = a ^ b ^ cin;          // XOR for sum
    assign cout = (a & b) | (b & cin) | (a & cin); // OR of ANDs for carry-out
endmodule