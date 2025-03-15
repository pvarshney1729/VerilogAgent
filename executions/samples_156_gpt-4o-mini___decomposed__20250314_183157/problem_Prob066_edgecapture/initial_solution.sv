module TopModule (
    input logic clk,
    input logic reset,
    input logic [31:0] in,
    output logic [31:0] out
);

always @(posedge clk) begin
    if (reset) begin
        out <= 32'b0;
    end else begin
        out <= (out | (in & ~{1'b0, in[31:1]})); // Capture transitions from 1 to 0
    end
end

endmodule