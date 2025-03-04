module TopModule (
    input  logic [3:0] in,            // 4-bit input vector
    output logic [3:0] out_both,      // 4-bit output vector
    output logic [3:0] out_any,       // 4-bit output vector
    output logic [3:0] out_different  // 4-bit output vector
);

    // Combinational logic for out_both
    always_comb begin
        out_both[2:0] = { (in[3] & in[2]), (in[2] & in[1]), (in[1] & in[0]) };
        out_both[3] = 1'b0; // No higher index neighbor for in[3]
    end

    // Combinational logic for out_any
    always_comb begin
        out_any[3:1] = { (in[3] | in[2]), (in[2] | in[1]), (in[1] | in[0]) };
        out_any[0] = 1'b0; // No lower index neighbor for in[0]
    end

    // Combinational logic for out_different
    always_comb begin
        out_different = { (in[3] ^ in[0]), (in[2] ^ in[3]), (in[1] ^ in[2]), (in[0] ^ in[1]) };
    end

endmodule