module TopModule (
    input logic [1023:0] in,
    input logic [7:0] sel,
    output logic [3:0] out
);

    always_comb begin
        if (sel <= 8'd255) begin
            out = in[(sel * 4) +: 4];
        end else begin
            out = 4'b0000;
        end
    end

endmodule