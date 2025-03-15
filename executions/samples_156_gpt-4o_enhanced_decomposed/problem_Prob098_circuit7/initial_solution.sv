module TopModule(
    input logic clk,
    input logic a,
    output logic q
);

    always_ff @(posedge clk) begin
        if (a == 0) begin
            q <= 1'b1;
        end else begin
            q <= 1'b0;
        end
    end

endmodule