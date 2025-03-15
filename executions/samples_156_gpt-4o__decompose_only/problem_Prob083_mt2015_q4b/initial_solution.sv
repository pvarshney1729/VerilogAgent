module TopModule (
    input  logic x,
    input  logic y,
    output logic z
);

    // Combinational logic to determine the output z
    always @(*) begin
        z = (~x & ~y) | (x & y);
    end

endmodule