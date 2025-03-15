module TopModule (
    input wire do_sub,
    input wire [7:0] a,
    input wire [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        // Perform addition or subtraction based on do_sub
        if (do_sub) begin
            out = a - b;
        end else begin
            out = a + b;
        end
        
        // Determine if the result is zero
        if (out == 8'b0) begin
            result_is_zero = 1'b1;
        end else begin
            result_is_zero = 1'b0;
        end
    end

endmodule