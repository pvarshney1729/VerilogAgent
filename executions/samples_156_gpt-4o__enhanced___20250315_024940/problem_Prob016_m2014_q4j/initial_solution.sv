module TopModule (
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [4:0] sum
);
    always @(*) begin
        sum = x + y; // Perform the addition and store the result in sum
    end
endmodule