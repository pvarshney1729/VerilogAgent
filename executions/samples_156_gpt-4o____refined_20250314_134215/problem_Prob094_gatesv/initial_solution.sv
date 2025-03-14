module TopModule (
    input logic [3:0] in,
    output logic [3:0] out_both,
    output logic [3:0] out_any,
    output logic [3:0] out_different
);

    // out_both: Check if both the current bit and its left neighbor are '1'
    always @(*) begin
        out_both[3] = 1'b0; // No left neighbor for in[3]
        out_both[2] = in[2] & in[3];
        out_both[1] = in[1] & in[2];
        out_both[0] = in[0] & in[1];
    end

    // out_any: Check if any of the current bit and its right neighbor are '1'
    always @(*) begin
        out_any[3] = in[3] | in[2];
        out_any[2] = in[2] | in[1];
        out_any[1] = in[1] | in[0];
        out_any[0] = 1'b0; // No right neighbor for in[0]
    end

    // out_different: Check if the current bit is different from its left neighbor
    always @(*) begin
        out_different[3] = in[3] ^ in[0]; // Wrap around
        out_different[2] = in[2] ^ in[3];
        out_different[1] = in[1] ^ in[2];
        out_different[0] = in[0] ^ in[1];
    end

endmodule