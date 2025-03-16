module TopModule(
    input  logic [255:0] in,
    input  logic [7:0]   sel,
    output logic         out
);
    // Combinational logic for 256-to-1 multiplexer
    assign out = in[sel];
endmodule