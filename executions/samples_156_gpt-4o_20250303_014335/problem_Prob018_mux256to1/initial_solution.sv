module TopModule (
    input  logic [255:0] in,  // 256-bit input vector
    input  logic [7:0]   sel, // 8-bit selector
    output logic         out  // 1-bit output
);

    always @(*) begin
        out = in[sel];
    end

endmodule