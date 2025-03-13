[BEGIN]
module TopModule (
    input logic a,        // First input bit (one bit)
    input logic b,        // Second input bit (one bit)
    input logic cin,      // Carry-in bit (one bit)
    output logic cout,    // Carry-out bit (one bit)
    output logic sum      // Sum output bit (one bit)
);

always @(*) begin
    sum = a ^ b ^ cin;                // Calculate the sum
    cout = (a & b) | (cin & (a ^ b)); // Calculate the carry-out
end

endmodule
[DONE]