module TopModule(
    input [3:0] in_vector,
    output [1:0] pos
);

    assign pos = (in_vector[3]) ? 2'b11 :
                 (in_vector[2]) ? 2'b10 :
                 (in_vector[1]) ? 2'b01 :
                 (in_vector[0]) ? 2'b00 : 2'b00;

endmodule