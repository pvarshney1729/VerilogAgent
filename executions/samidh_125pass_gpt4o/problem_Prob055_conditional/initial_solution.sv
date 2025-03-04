module TopModule (
    input  logic [7:0] input_a,
    input  logic [7:0] input_b,
    input  logic [7:0] input_c,
    input  logic [7:0] input_d,
    output logic [7:0] output_min
);

    always @(*) begin
        if (input_a <= input_b && input_a <= input_c && input_a <= input_d) begin
            output_min = input_a;
        end else if (input_b <= input_a && input_b <= input_c && input_b <= input_d) begin
            output_min = input_b;
        end else if (input_c <= input_a && input_c <= input_b && input_c <= input_d) begin
            output_min = input_c;
        end else begin
            output_min = input_d;
        end
    end

endmodule