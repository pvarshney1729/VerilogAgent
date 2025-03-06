```verilog
[BEGIN]
module TopModule (
    input logic a,    // 1-bit input
    input logic b,    // 1-bit input
    input logic c,    // 1-bit input
    input logic d,    // 1-bit input
    output logic out, // 1-bit output
    output logic out_n // 1-bit inverted output
);

    logic and1, and2; // Intermediate logic for AND gate outputs

    // Combinational logic using always block
    always @(*) begin
        and1 = a & b; // AND gate with inputs a and b
        and2 = c & d; // AND gate with inputs c and d
        out = and1 | and2; // OR gate with outputs from and1 and and2
        out_n = ~out; // Inversion of out
    end

endmodule
[DONE]
```