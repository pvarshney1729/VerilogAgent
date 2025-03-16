module TopModule(
    input logic [99:0] a,
    input logic [99:0] b,
    input logic sel,
    output logic [99:0] out
);

    // Implementing the 2-to-1 multiplexer logic
    assign out = sel ? b : a;

endmodule