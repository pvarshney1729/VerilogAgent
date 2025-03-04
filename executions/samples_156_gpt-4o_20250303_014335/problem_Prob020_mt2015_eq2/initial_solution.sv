module TopModule (
    input [1:0] A,
    input [1:0] B,
    output logic z
);

    // Combinational logic to check equality of A and B
    assign z = (A == B) ? 1'b1 : 1'b0;

endmodule