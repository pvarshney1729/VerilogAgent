module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);
    // Implementing the logic based on the simplified Karnaugh map
    always @(*) begin
        out = (~c & ~b & a) | (~c & a) | (c & b);
    end
endmodule