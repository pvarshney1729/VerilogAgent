module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    // Sum-of-Products (SOP) form
    always @(*) begin
        out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);
    end

    // Product-of-Sums (POS) form
    always @(*) begin
        out_pos = (a | ~b | ~c | d) & (~a | b | ~c | d) & (~a | ~b | c | d);
    end

endmodule