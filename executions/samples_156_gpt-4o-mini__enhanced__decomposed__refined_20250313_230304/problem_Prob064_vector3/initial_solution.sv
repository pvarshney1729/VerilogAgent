```verilog
[BEGIN]
module TopModule (
    input logic [4:0] a,  // 5-bit input vector a (unsigned)
    input logic [4:0] b,  // 5-bit input vector b (unsigned)
    input logic [4:0] c,  // 5-bit input vector c (unsigned)
    input logic [4:0] d,  // 5-bit input vector d (unsigned)
    input logic [4:0] e,  // 5-bit input vector e (unsigned)
    input logic [4:0] f,  // 5-bit input vector f (unsigned)
    output logic [7:0] w,  // 8-bit output vector w (unsigned)
    output logic [7:0] x,  // 8-bit output vector x (unsigned)
    output logic [7:0] y,  // 8-bit output vector y (unsigned)
    output logic [7:0] z   // 8-bit output vector z (unsigned)
);

    always @(*) begin
        {w, x, y, z} = {a, b, c, d, e, f, 2'b11}; // Concatenate and assign outputs
    end

endmodule
[DONE]
```