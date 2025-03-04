module TopModule (
    input logic a, // 1-bit unsigned input
    input logic b, // 1-bit unsigned input
    input logic c, // 1-bit unsigned input
    output logic out // 1-bit unsigned output
);

    // Combinational logic implementation based on the derived equation
    assign out = (a & b) | (a & c) | (~a & b);

endmodule