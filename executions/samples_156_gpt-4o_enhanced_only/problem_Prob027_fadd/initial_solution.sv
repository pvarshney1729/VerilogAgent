module TopModule(
    input  logic a,
    input  logic b,
    input  logic cin,
    output logic cout,
    output logic sum
);

    // Combinational logic for full adder
    always @(*) begin
        sum  = a ^ b ^ cin;                // XOR for sum
        cout = (a & b) | (b & cin) | (cin & a); // AND-OR for carry-out
    end

endmodule