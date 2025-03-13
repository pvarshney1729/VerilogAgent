module TopModule (
    input  logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    always @(*) begin
        // out_both: Check if both the current and left neighbor are '1'
        out_both[99] = 1'b0; // No left neighbor for in[99]
        for (int i = 0; i < 99; i++) begin
            out_both[i] = in[i] & in[i + 1];
        end

        // out_any: Check if either the current or right neighbor is '1'
        out_any[0] = 1'b0; // No right neighbor for in[0]
        for (int i = 1; i < 100; i++) begin
            out_any[i] = in[i] | in[i - 1];
        end

        // out_different: Check if current is different from left neighbor
        for (int i = 0; i < 100; i++) begin
            out_different[i] = in[i] ^ in[(i + 99) % 100]; // Wrap around
        end
    end

endmodule