module TopModule (
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [4:0] sum
);

    logic [4:0] temp_sum;

    always @(*) begin
        temp_sum = x + y; // Perform 4-bit addition
    end

    assign sum = temp_sum; // Assign the result to the output

endmodule