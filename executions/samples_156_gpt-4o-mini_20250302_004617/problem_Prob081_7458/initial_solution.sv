module chip_7458 (
    input logic A,
    input logic B,
    input logic C,
    output logic Y1,
    output logic Y2,
    output logic Y3,
    output logic Y4
);

    // Implementing the combinational logic for the 7458 chip
    always @(*) begin
        Y1 = A & B;          // AND operation for Y1
        Y2 = A | B;          // OR operation for Y2
        Y3 = A & C;          // AND operation for Y3
        Y4 = B | C;          // OR operation for Y4
    end

endmodule