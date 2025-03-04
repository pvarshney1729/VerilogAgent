module TopModule (
    input        sel,        // Selection line for the multiplexer
    input  logic [7:0] a,    // 8-bit input 'a'
    input  logic [7:0] b,    // 8-bit input 'b'
    output logic [7:0] out    // 8-bit output 'out'
);

// Implementation of the 8-bit 2-to-1 multiplexer
assign out = sel ? b : a; // Select 'b' if 'sel' is 1; otherwise, select 'a'.

endmodule