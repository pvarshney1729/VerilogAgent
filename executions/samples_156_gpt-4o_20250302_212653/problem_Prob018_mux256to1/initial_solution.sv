module TopModule (
    input logic [255:0] i_in,  // 256-bit input vector, unsigned
    input logic [7:0] i_sel,   // 8-bit selector input, unsigned
    output logic o_out         // 1-bit output, unsigned
);

    // Combinational logic for 256-to-1 multiplexer
    always @(*) begin
        o_out = i_in[i_sel];
    end

endmodule