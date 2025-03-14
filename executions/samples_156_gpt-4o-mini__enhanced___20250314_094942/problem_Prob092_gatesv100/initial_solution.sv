module TopModule (
    input logic [99:0] in,               // 100-bit input vector (in[99] is the MSB, in[0] is the LSB)
    output logic [99:0] out_both,        // 100-bit output vector indicating if both the bit and left neighbor are '1'
    output logic [99:0] out_any,         // 100-bit output vector indicating if any of the bit and right neighbor are '1'
    output logic [99:0] out_different     // 100-bit output vector indicating if the bit is different from the left neighbor
);

    always @(*) begin
        out_both = 100'b0; // Initialize out_both to zero
        out_any = 100'b0;  // Initialize out_any to zero
        out_different = 100'b0; // Initialize out_different to zero

        // Calculate out_both
        for (int i = 0; i < 99; i++) begin
            out_both[i] = in[i] && in[i + 1];
        end

        // out_both[99] is already initialized to 0

        // Calculate out_any
        out_any[0] = 1'b0; // No right neighbor for in[0]
        for (int i = 1; i < 100; i++) begin
            out_any[i] = in[i] || in[i - 1];
        end

        // Calculate out_different
        out_different[0] = (in[0] != in[99]); // Wrap-around condition
        for (int i = 1; i < 100; i++) begin
            out_different[i] = (in[i] != in[i - 1]);
        end
    end

endmodule