module EightBitMux (
    input  logic       sel,    // Single-bit selection input
    input  logic [7:0] a,      // 8-bit input a
    input  logic [7:0] b,      // 8-bit input b
    output logic [7:0] out     // 8-bit output
);

    // Perform bitwise selection based on the 'sel' signal.
    assign out = (sel == 1'b0) ? a : b;

endmodule