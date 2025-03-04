module TopModule (
    input  [254:0] in,
    output [7:0]   out
);

    logic [7:0] count;
    integer i;

    always @(*) begin
        count = 8'b0;
        for (i = 0; i < 255; i = i + 1) begin
            count = count + in[i];
        end
    end

    assign out = count;

endmodule