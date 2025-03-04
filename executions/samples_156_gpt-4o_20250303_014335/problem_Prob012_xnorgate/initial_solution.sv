module TopModule(
    input wire a,
    input wire b,
    output wire out
);
    // Combinational logic for XNOR
    assign out = ~(a ^ b);
endmodule