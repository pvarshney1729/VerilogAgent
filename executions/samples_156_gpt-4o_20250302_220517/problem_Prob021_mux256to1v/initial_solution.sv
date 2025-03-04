module TopModule (
    input logic [1023:0] in,
    input logic [7:0] sel,
    output logic [3:0] out
);

    always @(*) begin
        if (sel > 8'd255) begin
            out = 4'b0000;
        end else begin
            out = in[(sel * 4) +: 4];
        end
    end

endmodule