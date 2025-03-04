module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    // Initial state
    initial begin
        q = 1'b0;
    end

    // Sequential logic with synchronous reset
    always_ff @(posedge clk) begin
        if (a == 1'b1) begin
            q <= ~q;
        end
    end

endmodule