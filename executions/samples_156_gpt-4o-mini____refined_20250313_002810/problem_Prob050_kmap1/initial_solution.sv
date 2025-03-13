module TopModule (
    input logic a,
    input logic b,
    input logic c,
    output logic out
);

    always @(*) begin
        out = (b & ~c) | (a & b) | (a & c) | (~a & ~b & c);
    end

endmodule