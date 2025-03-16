module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

always @(*) begin
    q = (a & b & c) | (b & d) | (c & d) | (a & c & ~d);
end

endmodule