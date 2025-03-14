module TopModule (
    input  logic [7:0] a,    // Input a (8 bits, unsigned)
    input  logic [7:0] b,    // Input b (8 bits, unsigned)
    input  logic [7:0] c,    // Input c (8 bits, unsigned)
    input  logic [7:0] d,    // Input d (8 bits, unsigned)
    output logic [7:0] min   // Output min (8 bits, unsigned)
);

always @(*) begin
    // Initialize min to a
    min = a;
    
    // Compare with b, c, and d
    if (b < min) min = b;
    if (c < min) min = c;
    if (d < min) min = d;
end

endmodule