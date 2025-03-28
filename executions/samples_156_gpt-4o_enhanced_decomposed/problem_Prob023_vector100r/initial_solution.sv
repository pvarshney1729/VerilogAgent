module TopModule(
    input logic [99:0] in,
    output logic [99:0] out
);
    always @(*) begin
        integer i;
        for (i = 0; i < 100; i = i + 1) begin
            out[i] = in[99 - i];
        end
    end
endmodule