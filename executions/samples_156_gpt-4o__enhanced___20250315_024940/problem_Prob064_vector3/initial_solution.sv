module TopModule (
    input  logic [4:0] a,
    input  logic [4:0] b,
    input  logic [4:0] c,
    input  logic [4:0] d,
    input  logic [4:0] e,
    input  logic [4:0] f,
    output logic [7:0] w,
    output logic [7:0] x,
    output logic [7:0] y,
    output logic [7:0] z
);

    // Concatenate inputs and append two '1's
    logic [29:0] concatenated_inputs;
    assign concatenated_inputs = {a, b, c, d, e, f}; // 30 bits
    assign {z, y, x, w} = {concatenated_inputs, 2'b11}; // 32 bits total output

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly