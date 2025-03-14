module TopModule (
    input logic x,  // Input signal x
    input logic y,  // Input signal y
    output logic z  // Output signal z
);

always @(*) begin
    z = (x ^ y) & x;  // Combinational logic for output z
end

endmodule