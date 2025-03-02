module d_latch (
    input logic d,
    input logic ena,
    output logic q
);
    always @(*) begin
        if (ena) begin
            q = d;
        end
    end
endmodule