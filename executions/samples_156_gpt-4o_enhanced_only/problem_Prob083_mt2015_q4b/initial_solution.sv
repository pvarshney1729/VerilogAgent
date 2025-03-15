module TopModule(
    input logic x,
    input logic y,
    output logic z
);

    always @(*) begin
        // The logic to determine z based on x and y
        if ((x == 0 && y == 0) || (x == 1 && y == 1)) begin
            z = 1;
        end else begin
            z = 0;
        end
    end

endmodule