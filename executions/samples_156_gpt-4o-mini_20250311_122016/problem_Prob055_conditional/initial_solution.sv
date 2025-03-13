[BEGIN]
module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic [7:0] c,
    input logic [7:0] d,
    output logic [7:0] min
);
    
    always @(*) begin
        logic [7:0] min_ab;
        logic [7:0] min_abc;

        min_ab = (a < b) ? a : b;
        min_abc = (min_ab < c) ? min_ab : c;
        min = (min_abc < d) ? min_abc : d;
    end

endmodule
[DONE]