module TopModule (
    input  wire a,            // One-bit input signal 'a'
    input  wire b,            // One-bit input signal 'b'
    output wire out_assign,   // One-bit output signal from assign statement
    output wire out_alwaysblock // One-bit output signal from always block
);

    // Continuous assignment for combinational logic
    assign out_assign = a & b;

    // Combinational always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule