module TopModule(
    input logic [3:0] x,
    output logic f
);
    always @(*) begin
        f = (x[3] & x[4]) | (x[3] & ~x[4]) | (~x[3] & x[4] & x[1] & x[2]);
    end
endmodule