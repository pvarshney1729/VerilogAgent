module TopModule(
    input logic [7:0] in,
    output logic [31:0] out
);

    // Perform sign extension
    assign out = {{24{in[7]}}, in};

endmodule