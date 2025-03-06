module TopModule (
    input logic a,    // 1-bit input, unsigned
    input logic b,    // 1-bit input, unsigned
    input logic sel,  // 1-bit select input, unsigned
    output logic out  // 1-bit output, representing selected input
);

    // Combinational logic for 2-to-1 multiplexer
    always @(*) begin
        out = (sel == 1'b0) ? a : b;
    end

endmodule