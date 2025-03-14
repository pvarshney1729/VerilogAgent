[BEGIN]
module TopModule (
    input logic [2:0] in,
    output logic [1:0] out
);

    always @(*) begin
        out = 3'd0 + in[0] + in[1] + in[2];
    end

endmodule
[DONE]