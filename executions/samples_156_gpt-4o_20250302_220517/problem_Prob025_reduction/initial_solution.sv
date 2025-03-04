module TopModule (
    input logic [7:0] data_in,
    output logic parity
);

    // Calculate even parity by XORing all bits of data_in
    assign parity = ^data_in;

endmodule