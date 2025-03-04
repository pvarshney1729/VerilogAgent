module TopModule (
    input logic [99:0] a,   // 100-bit input vector
    input logic [99:0] b,   // 100-bit input vector
    input logic sel,        // 1-bit selection input
    output logic [99:0] out // 100-bit output vector
);

    // Combinational logic for 2-to-1 multiplexer
    always @(*) begin
        if (sel) begin
            out = b;
        end else begin
            out = a;
        end
    end

endmodule