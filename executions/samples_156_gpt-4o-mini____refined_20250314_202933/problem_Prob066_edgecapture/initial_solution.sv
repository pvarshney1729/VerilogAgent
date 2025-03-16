[BEGIN]
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic [31:0] in,
    output logic [31:0] out
);

    logic captured;

    always @(posedge clk) begin
        if (reset) begin
            captured <= 1'b0;
        end else begin
            captured <= (in != 32'b0 && (in & ~{in[31:0]})) ? 1'b1 : captured;
        end
    end

    assign out = {32{captured}};

endmodule
[DONE]