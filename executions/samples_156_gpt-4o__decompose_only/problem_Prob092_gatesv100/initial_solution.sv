module TopModule(
    input  logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    // out_both logic
    assign out_both[99] = 1'b0; // in[99] has no left neighbor
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_both_logic
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // out_any logic
    assign out_any[0] = 1'b0; // in[0] has no right neighbor
    generate
        for (i = 1; i < 100; i = i + 1) begin : out_any_logic
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // out_different logic
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_different_logic
            assign out_different[i] = in[i] ^ in[i+1];
        end
    endgenerate
    assign out_different[99] = in[99] ^ in[0]; // wrap-around case

endmodule