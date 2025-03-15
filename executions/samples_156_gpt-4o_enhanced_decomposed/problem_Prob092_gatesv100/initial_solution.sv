module TopModule(
    input logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    always @(*) begin
        // Compute out_both
        out_both[99] = 1'b0; // No left neighbor for in[99]
        for (int i = 0; i < 99; i = i + 1) begin
            out_both[i] = in[i] & in[i+1];
        end

        // Compute out_any
        out_any[0] = 1'b0; // No right neighbor for in[0]
        for (int i = 1; i < 100; i = i + 1) begin
            out_any[i] = in[i] | in[i-1];
        end

        // Compute out_different
        for (int i = 0; i < 99; i = i + 1) begin
            out_different[i] = in[i] ^ in[i+1];
        end
        out_different[99] = in[99] ^ in[0]; // Wrap around for in[99]
    end

endmodule