module top_module (
    input  logic [99:0] a,
    input  logic [99:0] b,
    input  logic        sel,
    output logic [99:0] out
);

    // Combinational logic for 2-1 multiplexer
    assign out = sel ? b : a;

endmodule