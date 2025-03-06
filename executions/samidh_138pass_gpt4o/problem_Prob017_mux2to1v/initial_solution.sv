module TopModule (
    input logic [99:0] a,  // 100-bit input vector, unsigned
    input logic [99:0] b,  // 100-bit input vector, unsigned
    input logic sel,       // 1-bit selection input
    output logic [99:0] out // 100-bit output vector, unsigned
);

    always @(*) begin
        if (sel == 1'b0) begin
            out = a;
        end else if (sel == 1'b1) begin
            out = b;
        end else begin
            out = 100'bx; // Undefined behavior for invalid sel
        end
    end

endmodule