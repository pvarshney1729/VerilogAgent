module TopModule(
    input logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    // Generate out_both
    assign out_both[99] = 1'b0; // Default for the last bit
    generate
        genvar i;
        for (i = 0; i < 99; i = i + 1) begin
            assign out_both[i] = in[i] & in[i+1];
        end
    endgenerate

    // Generate out_any
    assign out_any[0] = 1'b0; // Default for the first bit
    generate
        for (i = 1; i <= 99; i = i + 1) begin
            assign out_any[i] = in[i] | in[i-1];
        end
    endgenerate

    // Generate out_different
    generate
        for (i = 0; i <= 99; i = i + 1) begin
            if (i == 0) begin
                assign out_different[i] = in[i] ^ in[99];
            end else begin
                assign out_different[i] = in[i] ^ in[i-1];
            end
        end
    endgenerate

endmodule