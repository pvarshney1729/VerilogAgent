module TopModule (
    input  logic [99:0] a,   // 100-bit input vector, unsigned
    input  logic [99:0] b,   // 100-bit input vector, unsigned
    input  logic        sel, // 1-bit selection signal
    output logic [99:0] out  // 100-bit output vector, unsigned
);

    // Combinational logic for 2-to-1 multiplexer
    always @(*) begin
        if (sel == 1'b0) begin
            out = a;
        end else begin
            out = b;
        end
    end

endmodule