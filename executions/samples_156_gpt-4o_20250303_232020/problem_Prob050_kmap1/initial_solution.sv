module TopModule (
    input wire a,
    input wire b,
    input wire c,
    output wire out
);
    // Implement combinational logic as per the derived logical expression
    assign out = (a & b) | (b & c) | (~a & ~b & c);
endmodule