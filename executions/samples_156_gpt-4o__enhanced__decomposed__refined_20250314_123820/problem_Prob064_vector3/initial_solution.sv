[BEGIN]
module TopModule (
    input logic [4:0] a, // 5-bit input vector
    input logic [4:0] b, // 5-bit input vector
    input logic [4:0] c, // 5-bit input vector
    input logic [4:0] d, // 5-bit input vector
    input logic [4:0] e, // 5-bit input vector
    input logic [4:0] f, // 5-bit input vector
    output logic [7:0] w, // 8-bit output vector
    output logic [7:0] x, // 8-bit output vector
    output logic [7:0] y, // 8-bit output vector
    output logic [7:0] z  // 8-bit output vector
);

    always @(*) begin
        {w, x, y, z} = {a, b, c, d, e, f, 2'b11};
    end

endmodule
[DONE]