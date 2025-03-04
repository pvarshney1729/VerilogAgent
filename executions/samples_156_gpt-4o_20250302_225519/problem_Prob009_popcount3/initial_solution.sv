module TopModule (
    input  [2:0] in_vector,
    output [1:0] out_count
);

    assign out_count = in_vector[2] + in_vector[1] + in_vector[0];

endmodule