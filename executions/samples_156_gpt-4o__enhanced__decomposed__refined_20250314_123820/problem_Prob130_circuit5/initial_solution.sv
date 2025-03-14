[BEGIN]
module TopModule(
    input logic [3:0] a,
    input logic [3:0] b,
    input logic [3:0] c,
    input logic [3:0] d,
    input logic [3:0] e,
    output logic [3:0] q
);
    always @(*) begin
        case (c)
            4'd0: q = b;
            4'd1: q = e;
            4'd2: q = a;
            4'd3: q = d;
            4'd4, 4'd5, 4'd6, 4'd7, 4'd8, 4'd9: q = 4'b1111;
            default: q = 4'b1111;
        endcase
    end
endmodule
[DONE]