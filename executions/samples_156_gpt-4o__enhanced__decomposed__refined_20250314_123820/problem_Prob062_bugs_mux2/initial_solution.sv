[BEGIN]
module TopModule (
    input  logic       sel,    // Selection signal (1-bit)
    input  logic [7:0] a,      // 8-bit input vector 'a'
    input  logic [7:0] b,      // 8-bit input vector 'b'
    output logic [7:0] out     // 8-bit output vector 'out'
);

always @(*) begin
    out = (sel == 1'b0) ? a : b;  // Conditional operator selects between 'a' and 'b' based on 'sel'
end

endmodule
[DONE]