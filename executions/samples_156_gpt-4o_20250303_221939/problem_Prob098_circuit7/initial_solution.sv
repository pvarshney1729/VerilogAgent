module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    initial begin
        q = 1'b0;
    end

    always_ff @(posedge clk) begin
        if (a == 1'b1) begin
            q <= ~q;
        end
    end

endmodule