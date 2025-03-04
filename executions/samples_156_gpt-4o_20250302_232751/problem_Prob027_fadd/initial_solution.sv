module TopModule(
    input logic a,    // 1-bit input, represents one operand bit
    input logic b,    // 1-bit input, represents another operand bit
    input logic cin,  // 1-bit input, represents the carry-in bit
    output logic cout, // 1-bit output, represents the carry-out bit
    output logic sum   // 1-bit output, represents the sum bit
);

    // Combinational logic for full adder
    always_comb begin
        sum = a ^ b ^ cin; // XOR operation for sum
        cout = (a & b) | (b & cin) | (a & cin); // AND-OR operation for carry-out
    end

endmodule