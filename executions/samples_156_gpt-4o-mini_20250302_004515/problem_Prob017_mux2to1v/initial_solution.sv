module TopModule (
    input logic [99:0] a,   // 100-bit input, bit[0] is the least significant bit
    input logic [99:0] b,   // 100-bit input, bit[0] is the least significant bit
    input logic sel,        // 1-bit select line
    output logic [99:0] out // 100-bit output, bit[0] is the least significant bit
);

assign out = (sel) ? b : a;

endmodule