module TopModule (
    input  wire [15:0] a,   // 16-bit unsigned input
    input  wire [15:0] b,   // 16-bit unsigned input
    input  wire [15:0] c,   // 16-bit unsigned input
    input  wire [15:0] d,   // 16-bit unsigned input
    input  wire [15:0] e,   // 16-bit unsigned input
    input  wire [15:0] f,   // 16-bit unsigned input
    input  wire [15:0] g,   // 16-bit unsigned input
    input  wire [15:0] h,   // 16-bit unsigned input
    input  wire [15:0] i,   // 16-bit unsigned input
    input  wire [3:0]  sel, // 4-bit unsigned selector
    output reg  [15:0] out  // 16-bit unsigned output
);

always @(*) begin
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
        default: out = 16'hFFFF;
    endcase
end

endmodule