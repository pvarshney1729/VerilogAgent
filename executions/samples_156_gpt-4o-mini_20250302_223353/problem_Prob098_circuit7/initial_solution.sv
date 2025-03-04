module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    initial begin
        q = 1'b0; // Initial state
    end

    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= ~q; // Toggle output
        end
        // If a == 0, q remains unchanged
    end

endmodule