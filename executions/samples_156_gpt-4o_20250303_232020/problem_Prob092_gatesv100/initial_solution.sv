module TopModule (
    input  wire [99:0] in,         // 100-bit unsigned input vector
    output wire [99:0] out_both,   // 100-bit unsigned output vector
    output wire [99:0] out_any,    // 100-bit unsigned output vector
    output wire [99:0] out_different // 100-bit unsigned output vector
);

    // out_both logic
    assign out_both[99] = 1'b0;
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : gen_out_both
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // out_any logic
    assign out_any[0] = 1'b0;
    generate
        for (i = 1; i < 100; i = i + 1) begin : gen_out_any
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // out_different logic
    generate
        for (i = 0; i < 99; i = i + 1) begin : gen_out_different
            assign out_different[i] = in[i] ^ in[i+1];
        end
    endgenerate
    assign out_different[99] = in[99] ^ in[0];

endmodule