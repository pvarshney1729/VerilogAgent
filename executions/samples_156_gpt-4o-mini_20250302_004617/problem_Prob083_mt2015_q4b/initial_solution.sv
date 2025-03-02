module TopModule (
    input logic x,
    input logic y,
    output logic z
);

    always @(*) begin
        z = (x == 1'b0 && y == 1'b0) || (x == 1'b1 && y == 1'b1);
    end

endmodule