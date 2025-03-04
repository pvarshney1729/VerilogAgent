module TopModule (
    input logic x,
    input logic y,
    output logic z
);

    // Combinational logic to determine the output z
    always @(*) begin
        if ((x == 0 && y == 0) || (x == 1 && y == 1)) begin
            z = 1;
        end else begin
            z = 0;
        end
    end

endmodule