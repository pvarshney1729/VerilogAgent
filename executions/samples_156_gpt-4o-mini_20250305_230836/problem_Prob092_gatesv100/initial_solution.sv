module TopModule (
    input logic [99:0] in,
    output logic [99:0] out_both,
    output logic [99:0] out_any,
    output logic [99:0] out_different
);

    assign out_both[99] = 1'b0; // Boundary condition
    assign out_any[0] = 1'b0;   // Boundary condition

    always @(*) begin
        for (int i = 0; i < 99; i++) begin
            out_both[i] = in[i] & in[i + 1];
            out_any[i + 1] = in[i] | in[i - 1];
            out_different[i] = in[i] ^ in[i + 1];
        end
        out_different[99] = in[99] ^ in[0]; // Circular condition
    end

endmodule