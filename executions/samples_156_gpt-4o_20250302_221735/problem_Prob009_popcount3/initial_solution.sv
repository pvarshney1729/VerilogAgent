module TopModule(
    input wire [2:0] in,
    output wire [1:0] out
);

    assign out = in[2] + in[1] + in[0];

endmodule