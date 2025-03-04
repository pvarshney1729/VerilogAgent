module TopModule (
    input logic [1:0] A, // 2-bit input A
    input logic [1:0] B, // 2-bit input B
    output logic z       // 1-bit output z
);

    assign z = (A == B) ? 1'b1 : 1'b0;

endmodule