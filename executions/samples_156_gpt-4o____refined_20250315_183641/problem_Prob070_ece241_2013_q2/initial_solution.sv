module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out_sop,
    output logic out_pos
);

    // Minimum Sum-of-Products (SOP) form
    // Logic-1 for 2 (0010), 7 (0111), 15 (1111)
    // SOP: a'b'cd' + a'bcd + abcd
    always @(*) begin
        out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);
    end

    // Minimum Product-of-Sums (POS) form
    // Logic-0 for 0 (0000), 1 (0001), 4 (0100), 5 (0101), 6 (0110), 9 (1001), 10 (1010), 13 (1101), 14 (1110)
    // POS: (a + b + ~c + d) (a + ~b + c + ~d) (a + ~b + ~c + d) (~a + b + ~c + ~d)
    always @(*) begin
        out_pos = (a | b | ~c | d) & (a | ~b | c | ~d) & (a | ~b | ~c | d) & (~a | b | ~c | ~d);
    end

endmodule