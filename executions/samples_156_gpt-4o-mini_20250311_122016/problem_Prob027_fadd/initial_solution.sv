```
[BEGIN]
module TopModule(
    input  logic a,     // First operand input bit
    input  logic b,     // Second operand input bit
    input  logic cin,   // Carry-in input bit
    output logic cout,  // Carry-out output bit
    output logic sum    // Sum output bit
);

    // Combinational logic for sum and carry-out
    always @(*) begin
        sum  = a ^ b ^ cin;
        cout = (a & b) | (b & cin) | (a & cin);
    end

endmodule
[DONE]
```