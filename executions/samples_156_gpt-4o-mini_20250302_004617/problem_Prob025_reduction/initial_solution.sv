module even_parity (
    input logic [7:0] data,
    output logic parity
);

assign parity = ~^data;

endmodule