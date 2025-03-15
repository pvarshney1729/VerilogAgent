module refined_module (
    input logic clk,
    input logic reset,
    input logic a,
    input logic b,
    input logic c,
    output logic y
);

    always @(posedge clk) begin
        if (reset) begin
            y <= 1'b0;
        end else begin
            y <= (a & ~b & c) | (~a & b & c) | (a & b & ~c) | (a & ~b & ~c);
        end
    end

endmodule