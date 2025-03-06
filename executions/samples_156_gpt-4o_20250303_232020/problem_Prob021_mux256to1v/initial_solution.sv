module TopModule (
    input  logic [1023:0] in,
    input  logic [7:0]    sel,
    output logic [3:0]    out
);

    assign out = in[4*sel + 3 -: 4];

endmodule