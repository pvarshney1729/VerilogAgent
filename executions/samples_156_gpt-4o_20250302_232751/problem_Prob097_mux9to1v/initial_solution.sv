module TopModule (
    input  logic [15:0] a,   // 16-bit input
    input  logic [15:0] b,   // 16-bit input
    input  logic [15:0] c,   // 16-bit input
    input  logic [15:0] d,   // 16-bit input
    input  logic [15:0] e,   // 16-bit input
    input  logic [15:0] f,   // 16-bit input
    input  logic [15:0] g,   // 16-bit input
    input  logic [15:0] h,   // 16-bit input
    input  logic [15:0] i,   // 16-bit input
    input  logic [3:0]  sel, // 4-bit selection input
    output logic [15:0] out  // 16-bit output
);

    // This module implements a 16-bit wide, 9-to-1 multiplexer.
    // The 'sel' input determines which input signal is routed to the output 'out'.
    always_comb begin
        case (sel)
            4'd0: out = a;
            4'd1: out = b;
            4'd2: out = c;
            4'd3: out = d;
            4'd4: out = e;
            4'd5: out = f;
            4'd6: out = g;
            4'd7: out = h;
            4'd8: out = i;
            default: out = 16'hFFFF; // For sel=9 to 15, output is all '1's (16'hFFFF)
        endcase
    end

endmodule