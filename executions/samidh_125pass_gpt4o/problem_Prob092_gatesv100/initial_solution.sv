module TopModule(
    input logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    always_comb begin
        // Compute out_both
        for (int i = 0; i < 99; i++) begin
            out_both[i] = in[i] & in[i+1];
        end
        out_both[99] = 1'b0; // Special case for the last bit

        // Compute out_any
        out_any[0] = 1'b0; // Special case for the first bit
        for (int i = 1; i < 100; i++) begin
            out_any[i] = in[i] | in[i-1];
        end

        // Compute out_different
        for (int i = 0; i < 100; i++) begin
            out_different[i] = in[i] ^ in[(i+1) % 100];
        end
    end

endmodule