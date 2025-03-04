module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (~c & ~b & a) | (b & a) | (c & a) | (c & b & ~a);
    end

endmodule