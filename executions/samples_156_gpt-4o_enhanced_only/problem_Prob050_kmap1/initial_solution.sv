module TopModule(
    input logic a,
    input logic b,
    input logic c,
    output logic out
);
    always @(*) begin
        out = a | b | (c & ~b);
    end
endmodule