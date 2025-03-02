module RetainBits (
    input logic clk,
    input logic reset,
    input logic [31:0] in,
    output logic [31:0] out
);

    always_ff @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
        end else begin
            out <= out | in;
        end
    end

endmodule