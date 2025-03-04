module TopModule(
    input  wire [99:0] in,           // 100-bit input vector
    output wire [99:0] out_both,     // 100-bit output vector
    output wire [99:0] out_any,      // 100-bit output vector
    output wire [99:0] out_different // 100-bit output vector
);

    // out_both logic
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : gen_out_both
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate
    assign out_both[99] = 1'b0;

    // out_any logic
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_out_any
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate
    assign out_any[0] = 1'b0;

    // out_different logic
    assign out_different[0] = in[0] ^ in[99];
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_out_different
            assign out_different[i] = in[i] ^ in[i-1];
        end
    endgenerate

endmodule