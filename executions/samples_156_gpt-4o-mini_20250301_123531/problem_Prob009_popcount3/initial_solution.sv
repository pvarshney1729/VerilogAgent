module TopModule (
    input logic [2:0] in_vector,
    output logic [1:0] out_count
);

    always @(*) begin
        out_count = in_vector[0] + in_vector[1] + in_vector[2];
    end

endmodule