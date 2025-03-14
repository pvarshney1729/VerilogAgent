module TopModule (
    input  logic [3:0] a,  // Input signal 'a' (4 bits)
    input  logic [3:0] b,  // Input signal 'b' (4 bits)
    input  logic [3:0] c,  // Input signal 'c' (4 bits)
    input  logic [3:0] d,  // Input signal 'd' (4 bits)
    input  logic [3:0] e,  // Input signal 'e' (4 bits)
    output logic [3:0] q   // Output signal 'q' (4 bits)
);

always @(*) begin
    case (e)
        4'b0000: q = b;       // When e is 0, output is b
        4'b0001: q = e;       // When e is 1, output is e
        4'b0010: q = a;       // When e is 2, output is a
        4'b0011: q = d;       // When e is 3, output is d
        4'b0100: q = 4'b1111; // Dummy output for e=4
        4'b0101: q = 4'b1111; // Dummy output for e=5
        4'b0110: q = 4'b1111; // Dummy output for e=6
        4'b0111: q = 4'b1111; // Dummy output for e=7
        4'b1000: q = 4'b1111; // Dummy output for e=8
        4'b1001: q = 4'b1111; // Dummy output for e=9
        default: q = 4'bxxxx; // Default case to handle undefined behavior
    endcase
end

endmodule