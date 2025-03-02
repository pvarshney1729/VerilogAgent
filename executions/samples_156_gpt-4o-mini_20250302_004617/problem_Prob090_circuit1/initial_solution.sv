module TopModule (
    input logic a,
    input logic b,
    output logic q
);

    always @(*) begin
        q = a & b; // Combinational logic for AND operation
    end

endmodule