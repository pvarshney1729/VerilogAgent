module TopModule (
    input  logic [1023:0] in_vector,
    input  logic [7:0]    sel,
    output logic [3:0]    out
);

    always @(*) begin
        if (sel <= 8'd255) begin
            out = in_vector[(sel * 4) +: 4];
        end else begin
            out = 4'b0000;
        end
    end

endmodule