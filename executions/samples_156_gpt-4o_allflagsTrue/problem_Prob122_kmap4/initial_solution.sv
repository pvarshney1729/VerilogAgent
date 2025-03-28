module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (~c & ~d & ~a & b) |
              (~c & ~d & a & ~b) |
              (~c & d & ~a & ~b) |
              (~c & d & a & b) |
              (c & d & ~a & b) |
              (c & d & a & ~b) |
              (c & ~d & ~a & ~b) |
              (c & ~d & a & b);
    end

endmodule