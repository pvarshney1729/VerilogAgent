module TopModule(
    input  logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    // out_both logic
    always_comb begin
        integer i;
        for (i = 0; i < 99; i = i + 1) begin
            out_both[i] = in[i] & in[i+1];
        end
        out_both[99] = 1'b0; // Boundary condition
    end

    // out_any logic
    always_comb begin
        integer i;
        out_any[0] = 1'b0; // Boundary condition
        for (i = 1; i < 100; i = i + 1) begin
            out_any[i] = in[i] | in[i-1];
        end
    end

    // out_different logic
    always_comb begin
        integer i;
        for (i = 0; i < 99; i = i + 1) begin
            out_different[i] = in[i] ^ in[i+1];
        end
        out_different[99] = in[99] ^ in[0]; // Wrap-around logic
    end

endmodule