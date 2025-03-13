module TopModule (
    input  logic a,
    input  logic b,
    input  logic cin,
    output logic cout,
    output logic sum
);

    always @(*) begin
        sum = a ^ b ^ cin;        // Sum calculation
        cout = (a & b) | (cin & (a ^ b)); // Carry-out calculation
    end

endmodule