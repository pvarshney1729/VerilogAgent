module TopModule(
    input logic a,
    input logic b,
    output logic q
);

    // Combinational logic to determine q based on inputs a and b
    always @(*) begin
        q = a & b; // q is high only when both a and b are high
    end

endmodule