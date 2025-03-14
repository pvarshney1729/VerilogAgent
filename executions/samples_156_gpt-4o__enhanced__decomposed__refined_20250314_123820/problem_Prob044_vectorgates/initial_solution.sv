[BEGIN]
module TopModule(
    input logic [2:0] a,
    input logic [2:0] b,
    output logic [2:0] out_or_bitwise,
    output logic out_or_logical,
    output logic [5:0] out_not
);

    always @(*) begin
        // Bitwise OR operation
        out_or_bitwise = a | b;
        
        // Logical OR operation
        out_or_logical = (|a) | (|b);
        
        // Bitwise NOT operation
        out_not = {~b, ~a};
    end

endmodule
[DONE]