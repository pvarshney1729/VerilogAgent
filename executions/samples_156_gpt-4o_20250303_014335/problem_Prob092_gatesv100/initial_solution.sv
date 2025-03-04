module TopModule (
    input [99:0] in,              // 100-bit unsigned input vector
    output [99:0] out_both,       // 100-bit unsigned output vector
    output [99:0] out_any,        // 100-bit unsigned output vector
    output [99:0] out_different   // 100-bit unsigned output vector
);

    // out_both logic
    assign out_both[99] = 1'b0;
    genvar i;
    generate
        for (i = 0; i < 99; i = i + 1) begin : out_both_logic
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // out_any logic
    assign out_any[0] = 1'b0;
    generate
        for (i = 1; i < 100; i = i + 1) begin : out_any_logic
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // out_different logic
    assign out_different[0] = in[0] ^ in[99];
    generate
        for (i = 1; i < 100; i = i + 1) begin : out_different_logic
            assign out_different[i] = in[i] ^ in[i-1];
        end
    endgenerate

endmodule