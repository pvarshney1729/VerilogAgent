module TopModule (
    input  logic [15:0] a,     // Input signal a (16 bits)
    input  logic [15:0] b,     // Input signal b (16 bits)
    input  logic [15:0] c,     // Input signal c (16 bits)
    input  logic [15:0] d,     // Input signal d (16 bits)
    input  logic [15:0] e,     // Input signal e (16 bits)
    input  logic [15:0] f,     // Input signal f (16 bits)
    input  logic [15:0] g,     // Input signal g (16 bits)
    input  logic [15:0] h,     // Input signal h (16 bits)
    input  logic [15:0] i,     // Input signal i (16 bits)
    input  logic [3:0]  sel,   // Select signal (4 bits)
    output logic [15:0] out    // Output signal out (16 bits)
);

always @(*) begin
    case(sel)
        4'b0000: out = a; // sel = 0 chooses a
        4'b0001: out = b; // sel = 1 chooses b
        4'b0010: out = c; // sel = 2 chooses c
        4'b0011: out = d; // sel = 3 chooses d
        4'b0100: out = e; // sel = 4 chooses e
        4'b0101: out = f; // sel = 5 chooses f
        4'b0110: out = g; // sel = 6 chooses g
        4'b0111: out = h; // sel = 7 chooses h
        4'b1000: out = i; // sel = 8 chooses i
        default: out = 16'hFFFF; // sel = 9 to 15 sets out to all '1's (0xFFFF)
    endcase
end

endmodule