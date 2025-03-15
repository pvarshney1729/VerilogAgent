module TopModule (
    input  logic x,
    input  logic y,
    output logic z
);

    // Combinational logic to implement z = (x^y) & x
    always @(*) begin
        z = (x ^ y) & x;
    end

endmodule