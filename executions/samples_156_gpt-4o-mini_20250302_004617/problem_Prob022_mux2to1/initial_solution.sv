module mux2to1 (
    input logic a,
    input logic b,
    input logic sel,
    output logic y
);

    always @(*) begin
        if (sel) begin
            y = b;
        end else begin
            y = a;
        end
    end

endmodule