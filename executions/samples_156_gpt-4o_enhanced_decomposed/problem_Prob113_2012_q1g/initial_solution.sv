module TopModule(
    input logic [3:0] x,
    output logic f
);
    always @(*) begin
        f = (~x[2] & ~x[3] & x[0]) | (x[2] & x[3]) | (~x[2] & x[3] & ~x[1]);
    end
endmodule