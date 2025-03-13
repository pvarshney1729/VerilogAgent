module TopModule (
    input  logic [3:0] x,
    input  logic [3:0] y,
    output logic [4:0] sum
);

    logic [4:0] full_sum;

    always @(*) begin
        full_sum = {1'b0, x} + {1'b0, y}; // Perform 4-bit addition with overflow
    end

    assign sum = full_sum; // Assign the result to the output

endmodule