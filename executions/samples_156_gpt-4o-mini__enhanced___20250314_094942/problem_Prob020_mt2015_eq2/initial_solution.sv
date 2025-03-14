module TopModule (
    input logic [1:0] A,      // Input A - 2 bits, A[0] is LSB, A[1] is MSB
    input logic [1:0] B,      // Input B - 2 bits, B[0] is LSB, B[1] is MSB
    output logic z            // Output z - 1 bit
);

always @(*) begin
    z = (A == B) ? 1'b1 : 1'b0;  // Output assignment based on comparison
end

endmodule