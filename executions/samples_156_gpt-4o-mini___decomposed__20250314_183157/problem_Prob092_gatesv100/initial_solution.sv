module TopModule (
    input  logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);
    assign out_both[98:0] = in[99:1] & in[98:0]; // Both current and left neighbor are 1
    assign out_both[99] = 1'b0; // No left neighbor for in[99]

    assign out_any[0] = 1'b0; // No right neighbor for in[0]
    assign out_any[99] = in[99] | in[98]; // Last bit check
    assign out_any[98:1] = in[98:0] | in[99:1]; // Check if any current or right neighbor is 1

    assign out_different = in ^ {in[0], in[99:1]}; // Different from left neighbor with wrap around

endmodule