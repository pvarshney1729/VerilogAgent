module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

always @(*) begin
    q = (a & b & c) | (b & d) | (a & c & ~d) | (a & ~b & d);
end

endmodule