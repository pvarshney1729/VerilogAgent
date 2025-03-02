module TopModule (
    input logic a,
    input logic b,
    output logic out
);

    // Combinational logic for 2-input AND gate
    always @(*) begin
        out = a & b;
    end

endmodule