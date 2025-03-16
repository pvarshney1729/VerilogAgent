module TopModule (
    input [7:0] input_data,
    output [7:0] output_data
);
    assign output_data = {input_data[0], input_data[1], input_data[2], input_data[3], 
                          input_data[4], input_data[5], input_data[6], input_data[7]};
endmodule