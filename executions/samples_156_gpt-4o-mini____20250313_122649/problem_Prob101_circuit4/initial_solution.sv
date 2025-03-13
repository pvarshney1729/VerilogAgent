module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

always @(*) begin
    q = (a & b) | (c & d) | (b & ~c) | (a & ~d);
end

endmodule