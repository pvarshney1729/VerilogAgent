module TopModule(
    input  logic [7:0]  in,
    output logic [31:0] out
);

    // Sign-extension operation
    assign out = {{24{in[7]}}, in};

endmodule