module TopModule (
    input  logic [15:0] data_in,
    output logic [7:0]  out_hi,
    output logic [7:0]  out_lo
);

    // Combinational logic to split the input into high and low bytes
    always_comb begin
        out_hi = data_in[15:8];
        out_lo = data_in[7:0];
    end

endmodule