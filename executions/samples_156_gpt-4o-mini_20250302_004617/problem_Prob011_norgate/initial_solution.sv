module TopModule (
    input logic a,
    input logic b,
    input logic clk,
    input logic reset,
    output logic out
);

    always @(posedge clk) begin
        if (reset) begin
            out <= 1'b0;
        end else begin
            out <= ~(a | b);
        end
    end

endmodule