module TopModule (
    input logic a,
    input logic b,
    input logic c,
    output logic out
);

    // Implement the logic based on the derived Boolean expression
    assign out = a | (~b & ~c);

endmodule