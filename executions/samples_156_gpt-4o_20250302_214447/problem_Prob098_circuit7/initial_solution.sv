module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    // Initialize q to 0
    initial begin
        q = 1'b0;
    end

    // Sequential logic block
    always_ff @(posedge clk) begin
        if (a == 1'b1) begin
            q <= ~q; // Toggle q if a is 1
        end
        // If a is 0, q retains its value (no action needed)
    end

endmodule