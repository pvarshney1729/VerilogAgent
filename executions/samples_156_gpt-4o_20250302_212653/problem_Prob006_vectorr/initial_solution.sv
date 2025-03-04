module TopModule (
    input  logic [7:0] input_data,
    output logic [7:0] output_data
);

    always @(*) begin
        output_data[0] = input_data[7];
        output_data[1] = input_data[6];
        output_data[2] = input_data[5];
        output_data[3] = input_data[4];
        output_data[4] = input_data[3];
        output_data[5] = input_data[2];
        output_data[6] = input_data[1];
        output_data[7] = input_data[0];
    end

endmodule