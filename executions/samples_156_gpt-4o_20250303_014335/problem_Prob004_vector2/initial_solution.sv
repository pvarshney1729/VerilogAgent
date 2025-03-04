module TopModule (
    input  wire [31:0] in,  // 32-bit unsigned input vector
    output wire [31:0] out  // 32-bit unsigned output vector
);

    // Correct byte reversal as per specification
    assign out = {in[31:24], in[23:16], in[15:8], in[7:0]};

endmodule