module TopModule (
    input  [31:0] in_data,
    output [31:0] out_data
);

    assign out_data = {in_data[7:0], in_data[15:8], in_data[23:16], in_data[31:24]};

endmodule