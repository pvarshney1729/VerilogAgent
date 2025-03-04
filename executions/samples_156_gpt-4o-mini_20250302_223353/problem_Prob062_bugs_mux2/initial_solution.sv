module TopModule (
    input        sel,         // Selection signal (1 bit)
    input  logic [7:0] a,    // 8-bit input operand A
    input  logic [7:0] b,    // 8-bit input operand B
    output logic [7:0] out    // 8-bit output result
);

    // Combinational logic:
    assign out = sel ? b : a;

endmodule