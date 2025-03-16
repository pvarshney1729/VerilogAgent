module TopModule(
    input logic [1:0] A,
    input logic [1:0] B,
    output logic z
);

    // Combinational logic to compare A and B
    assign z = (A == B) ? 1'b1 : 1'b0;

endmodule