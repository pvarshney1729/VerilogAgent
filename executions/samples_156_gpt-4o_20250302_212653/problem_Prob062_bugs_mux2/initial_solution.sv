module TopModule (
    input logic       sel,   // 1-bit select signal
    input logic [7:0] a,     // 8-bit input port 'a'
    input logic [7:0] b,     // 8-bit input port 'b'
    output logic [7:0] out   // 8-bit output port
);

// Implementation:
assign out = sel ? b : a;

endmodule