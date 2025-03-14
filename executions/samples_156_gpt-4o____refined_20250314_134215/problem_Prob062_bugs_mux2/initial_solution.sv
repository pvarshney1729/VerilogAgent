[BEGIN]
module TopModule (
    input logic       sel,
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] out
);

    always @(*) begin
        out = (sel == 1'b1) ? b : a;
    end

endmodule
[DONE]