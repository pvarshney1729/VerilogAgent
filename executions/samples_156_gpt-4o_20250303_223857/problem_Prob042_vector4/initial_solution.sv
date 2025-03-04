module SignExtend_8to32 (
    input logic signed [7:0] data_in,
    output logic signed [31:0] data_out
);
    assign data_out = { {24{data_in[7]}}, data_in };
endmodule