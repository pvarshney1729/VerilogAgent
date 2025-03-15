module TopModule (
    input logic x,
    input logic y,
    output logic z
);

    always @(*) begin
        z = (x ^ y) & x;
    end

endmodule