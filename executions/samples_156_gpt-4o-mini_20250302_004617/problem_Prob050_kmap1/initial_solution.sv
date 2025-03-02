module combinational_logic (
    input logic a,
    input logic b,
    input logic c,
    output logic f
);

    always @(*) begin
        f = (a & b) | (~a & c);
    end

endmodule