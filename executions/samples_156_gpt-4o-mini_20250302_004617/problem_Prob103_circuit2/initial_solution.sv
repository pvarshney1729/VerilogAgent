module combinational_logic (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic y
);

always @(*) begin
    y = (a & b) | (c & ~d);
end

endmodule