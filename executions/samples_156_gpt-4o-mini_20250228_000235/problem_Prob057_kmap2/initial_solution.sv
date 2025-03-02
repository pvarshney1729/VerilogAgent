module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (a & ~b & ~c & ~d) | // 00 00
              (a & ~b & d) |     // 00 10
              (a & c & d) |      // 01 11
              (b & c & d) |      // 10 11
              (b & ~a & d) |     // 01 10
              (~a & b & c);      // 11 01
    end

endmodule