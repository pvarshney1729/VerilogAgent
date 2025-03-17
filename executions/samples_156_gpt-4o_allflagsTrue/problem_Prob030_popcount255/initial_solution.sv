module TopModule(
    input logic [254:0] in,
    output logic [7:0] out
);

    always @(*) begin
        integer i;
        logic [7:0] count;
        count = 8'b0;
        for (i = 0; i < 255; i = i + 1) begin
            count = count + in[i];
        end
        out = count;
    end

endmodule