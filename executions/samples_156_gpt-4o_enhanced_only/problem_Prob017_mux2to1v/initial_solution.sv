module TopModule(
    input logic [99:0] a,   // 100-bit input vector
    input logic [99:0] b,   // 100-bit input vector
    input logic sel,        // 1-bit select signal
    output logic [99:0] out // 100-bit output vector
);
    // Combinational logic for 2-to-1 multiplexer
    always @(*) begin
        if (sel) begin
            out = b; // Select input b when sel is 1
        end else begin
            out = a; // Select input a when sel is 0
        end
    end
endmodule