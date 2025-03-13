module TopModule (
    input logic [254:0] in,
    output logic [7:0] out
);
    logic [7:0] count;

    always @(*) begin
        count = 8'b0;
        for (int i = 0; i < 255; i++) begin
            count = count + in[i];
        end
    end

    assign out = count;

endmodule