[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

always_comb begin
    q = (a & ~b & c) | (~a & b & ~c) | (~a & ~b & c & d) | (a & b & ~c & ~d) | (~a & b & c & ~d) | (a & ~b & ~c & d) | (a & b & c & d);
end

endmodule
[DONE]