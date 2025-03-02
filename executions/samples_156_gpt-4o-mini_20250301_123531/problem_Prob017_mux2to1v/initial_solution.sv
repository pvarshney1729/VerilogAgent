module TopModule (
    input logic [99:0] a,    // 100-bit input a
    input logic [99:0] b,    // 100-bit input b
    input logic sel,         // 1-bit select line
    output logic [99:0] out  // 100-bit output
);

    always @(*) begin
        out = (sel) ? b : a;  // Multiplexer logic
    end

endmodule