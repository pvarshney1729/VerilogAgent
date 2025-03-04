module TopModule (
    input  logic       sel,       // 1-bit select line
    input  logic [7:0] a,         // 8-bit input data 0
    input  logic [7:0] b,         // 8-bit input data 1
    output logic [7:0] mux_out    // 8-bit multiplexer output
);

    // Combinational logic to select between `a` and `b` based on `sel`
    assign mux_out = sel ? b : a;

endmodule