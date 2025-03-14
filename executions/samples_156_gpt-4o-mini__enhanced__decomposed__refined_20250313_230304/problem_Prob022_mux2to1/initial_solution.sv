module TopModule (
    input logic a,      // Input signal 'a'; 1-bit wide
    input logic b,      // Input signal 'b'; 1-bit wide
    input logic sel,    // Select signal 'sel'; 1-bit wide
    output logic out    // Output signal 'out'; 1-bit wide
);

always @(*) begin
    case (sel)
        1'b0: out = a; // If sel is 0, output 'a'
        1'b1: out = b; // If sel is 1, output 'b'
        default: out = 1'b0; // Default case to ensure 'out' is defined
    endcase
end

endmodule