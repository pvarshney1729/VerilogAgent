module TopModule (
    input logic [2:0] in,
    output logic [1:0] out
);

    assign out = in[2] + in[1] + in[0];

endmodule