module TopModule(
    input logic [31:0] data_in,
    output logic [31:0] data_out
);

    always @(*) begin
        data_out[31:24] = data_in[7:0];
        data_out[23:16] = data_in[15:8];
        data_out[15:8] = data_in[23:16];
        data_out[7:0] = data_in[31:24];
    end

endmodule