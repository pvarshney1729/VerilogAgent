module TopModule (
    logic clk,
    logic a,
    logic reset,
    logic [2:0] q
);

    always @(*) begin
        if (reset) begin
            q <= 3'b000;
        end else if (a == 0) begin
            q <= q + 1;
        end
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly