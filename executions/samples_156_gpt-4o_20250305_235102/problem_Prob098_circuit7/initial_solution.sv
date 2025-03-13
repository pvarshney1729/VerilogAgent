module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    // Initialize q to 0
    initial begin
        q = 1'b0;
    end

    // Sequential logic to toggle q based on input a
    always_ff @(posedge clk) begin
        if (a == 1'b1) begin
            q <= ~q;
        end
    end

endmodule