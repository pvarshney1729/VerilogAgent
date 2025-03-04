module TopModule (
    input  logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    always @(*) begin
        out_both[99] = 1'b0; // Boundary condition
        for (int i = 0; i < 99; i++) begin
            out_both[i] = in[i] & in[i + 1];
        end
    end

    always @(*) begin
        out_any[0] = 1'b0; // Boundary condition
        for (int i = 1; i < 100; i++) begin
            out_any[i] = in[i] | in[i - 1];
        end
    end

    always @(*) begin
        for (int i = 0; i < 100; i++) begin
            out_different[i] = in[i] ^ in[(i == 0) ? 99 : i - 1];
        end
    end

endmodule