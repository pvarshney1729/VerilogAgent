module TopModule (
    input logic [3:0] in,
    output logic [3:0] out_both,
    output logic [3:0] out_any,
    output logic [3:0] out_different
);

    // Combinational logic for out_both
    always @(*) begin
        out_both[3] = 1'b0; // No neighbour to the left for in[3]
        out_both[2] = in[2] & in[3];
        out_both[1] = in[1] & in[2];
        out_both[0] = in[0] & in[1];
    end

    // Combinational logic for out_any
    always @(*) begin
        out_any[3] = in[3] | in[2];
        out_any[2] = in[2] | in[1];
        out_any[1] = in[1] | in[0];
        out_any[0] = 1'b0; // No neighbour to the right for in[0]
    end

    // Combinational logic for out_different
    always @(*) begin
        out_different[3] = in[3] ^ in[0]; // Wrap around
        out_different[2] = in[2] ^ in[3];
        out_different[1] = in[1] ^ in[2];
        out_different[0] = in[0] ^ in[1];
    end

endmodule