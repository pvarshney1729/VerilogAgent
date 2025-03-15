module TopModule (
    input logic [7:0] in,
    output logic parity
);
    assign parity = ^in; // Even parity calculation
endmodule