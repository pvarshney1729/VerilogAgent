module TopModule (
    input logic do_sub,
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] out,
    output logic result_is_zero
);

    always @(*) begin
        if (do_sub) 
            out = a - b;
        else 
            out = a + b;

        result_is_zero = (out == 8'b0);
    end

endmodule