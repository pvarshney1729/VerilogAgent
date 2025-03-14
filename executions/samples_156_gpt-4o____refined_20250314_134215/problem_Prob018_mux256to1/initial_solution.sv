[BEGIN]
module TopModule (
    input logic [255:0] in,
    input logic [7:0] sel,
    output logic out
);

    always @(*) begin
        if (sel < 8'd256) begin
            out = in[sel];
        end else begin
            out = 1'b0;
        end
    end

endmodule
[DONE]