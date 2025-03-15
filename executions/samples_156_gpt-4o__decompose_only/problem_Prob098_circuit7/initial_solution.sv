module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 1'b0;
        end else begin
            q <= 1'b1;
        end
    end

endmodule