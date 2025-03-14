```verilog
module TopModule (
    input logic a,       // Input 'a' (1-bit)
    input logic b,       // Input 'b' (1-bit)
    output logic sum,    // Output 'sum' (1-bit)
    output logic cout    // Output 'cout' (1-bit)
);

assign sum = a ^ b;    // Sum output: XOR of inputs
assign cout = a & b;   // Carry-out output: AND of inputs

endmodule
```