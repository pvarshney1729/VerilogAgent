module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (~c & ~d) | (c & ~d & a) | (~c & ~b) | (a & ~d);
    end

endmodule