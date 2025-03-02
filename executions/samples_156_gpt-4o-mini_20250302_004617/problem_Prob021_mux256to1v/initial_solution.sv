module TopModule (
    input logic [7:0] sel,
    input logic [1023:0] in_vector,
    output logic [3:0] out_segment
);

    always @(*) begin
        out_segment = in_vector[sel * 4 +: 4];
    end

endmodule