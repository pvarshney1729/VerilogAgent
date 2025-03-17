module TopModule (
    input  logic [1023:0] in,
    input  logic [7:0]    sel,
    output logic [3:0]    out
);

    // Combinational logic to select the appropriate 4-bit segment
    assign out = in[sel * 4 +: 4];

endmodule