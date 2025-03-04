module TopModule(
    input logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    // Generate out_both
    assign out_both[99] = 1'b0;
    generate
        genvar i;
        for (i = 0; i < 99; i = i + 1) begin
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Generate out_any
    assign out_any[0] = 1'b0;
    generate
        for (i = 1; i < 100; i = i + 1) begin
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Generate out_different
    assign out_different[0] = in[0] ^ in[99];
    generate
        for (i = 1; i < 100; i = i + 1) begin
            assign out_different[i] = in[i] ^ in[i-1];
        end
    endgenerate

endmodule