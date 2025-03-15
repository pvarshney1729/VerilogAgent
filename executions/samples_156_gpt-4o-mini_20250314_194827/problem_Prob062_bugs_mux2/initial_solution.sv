module mux2to1 (
    input logic sel,
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] out
);

    always @(*) begin
        out = sel ? b : a;
    end

endmodule