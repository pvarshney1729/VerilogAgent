module TopModule(
    input logic signed [7:0] in,
    output logic signed [31:0] out
);

    assign out = {{24{in[7]}}, in};

endmodule