module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (~c & ~d) | (c & a & ~b) | (b & ~c & ~d) | (~a & ~b & d);
    end

endmodule