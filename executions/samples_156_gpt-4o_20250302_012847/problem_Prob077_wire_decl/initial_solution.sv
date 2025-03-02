module combinational_logic (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic y
);

    logic and1_out, and2_out;

    always @(*) begin
        and1_out = a & b;
        and2_out = c & d;
        y = and1_out | and2_out;
    end

endmodule