```verilog
module TopModule(
    input  [4:0] a,
    input  [4:0] b,
    input  [4:0] c,
    input  [4:0] d,
    input  [4:0] e,
    input  [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);

    logic [31:0] concatenated_vector;

    // Concatenate inputs and append two '1' bits
    assign concatenated_vector = {a, b, c, d, e, f, 2'b11};

    // Split the 32-bit vector into four 8-bit outputs
    assign w = concatenated_vector[31:24];
    assign x = concatenated_vector[23:16];
    assign y = concatenated_vector[15:8];
    assign z = concatenated_vector[7:0];

endmodule
```