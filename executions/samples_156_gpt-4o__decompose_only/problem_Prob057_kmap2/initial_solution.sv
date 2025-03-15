module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out
);

    always @(*) begin
        // Implementing the logic derived from the Karnaugh map
        out = (~c & ~d) |  // Covers ab = 00, 01, 10 when cd = 00
              (~a & ~b & d) |  // Covers ab = 00 when cd = 01
              (a & b & c) |  // Covers ab = 11 when cd = 11
              (a & ~b & ~c);  // Covers ab = 10 when cd = 00
    end

endmodule