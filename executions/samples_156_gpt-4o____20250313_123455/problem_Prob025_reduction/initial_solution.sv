module TopModule (
    input logic [7:0] in,
    output logic parity
);

    always @(*) begin
        parity = ^in; // XOR all bits of 'in' to compute even parity
    end

endmodule