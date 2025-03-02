module TopModule (
    input logic clk,
    input logic reset,
    output logic out
);

    always @(posedge clk) begin
        if (reset) begin
            out <= 1'b0;
        end else begin
            out <= 1'b1;
        end
    end

endmodule