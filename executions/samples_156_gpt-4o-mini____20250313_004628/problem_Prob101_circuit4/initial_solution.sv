module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

always @(*) begin
    q = (a & b & c) | (a & b & d) | (a & c & d) | (b & c & d);
end

endmodule