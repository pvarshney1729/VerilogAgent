module TopModule (
    input logic a,
    input logic b,
    input logic cin,
    output logic cout,
    output logic sum
);

    // Combinational logic for sum and carry-out
    always @(*) begin
        sum = a ^ b ^ cin; // sum is the XOR of a, b, and cin
        cout = (a & b) | (cin & (a ^ b)); // cout is derived from a and b, and cin
    end

endmodule