module TopModule(
    input logic [254:0] in,
    output logic [7:0] out
);

    always @(*) begin
        integer i;
        out = 8'd0;
        for (i = 0; i < 255; i = i + 1) begin
            out = out + in[i];
        end
    end

endmodule