module TopModule (
    input logic [255:0] data_in,
    input logic [7:0] select,
    output logic data_out
);

    always @(*) begin
        data_out = data_in[select];
    end

endmodule