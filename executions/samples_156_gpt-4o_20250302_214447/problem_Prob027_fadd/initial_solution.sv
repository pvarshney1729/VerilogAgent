module TopModule (
    input logic a,    // One-bit input, part of the operands
    input logic b,    // One-bit input, part of the operands
    input logic cin,  // One-bit input, carry-in for the full adder
    output logic cout, // One-bit output, carry-out from the full adder
    output logic sum   // One-bit output, sum result from the full adder
);

    always_comb begin
        sum = a ^ b ^ cin; // Sum calculation
        cout = (a & b) | (cin & (a ^ b)); // Carry-out calculation
    end

endmodule