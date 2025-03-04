module TopModule(
    input logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    // Calculate out_both
    always @(*) begin
        integer i;
        for (i = 0; i < 99; i = i + 1) begin
            out_both[i] = in[i] & in[i+1];
        end
        out_both[99] = 1'b0; // No neighbor to the left for in[99]
    end

    // Calculate out_any
    always @(*) begin
        integer i;
        out_any[0] = 1'b0; // No neighbor to the right for in[0]
        for (i = 1; i < 100; i = i + 1) begin
            out_any[i] = in[i] | in[i-1];
        end
    end

    // Calculate out_different
    always @(*) begin
        integer i;
        out_different[0] = in[0] ^ in[99]; // Wrap around
        for (i = 1; i < 100; i = i + 1) begin
            out_different[i] = in[i] ^ in[i-1];
        end
    end

endmodule