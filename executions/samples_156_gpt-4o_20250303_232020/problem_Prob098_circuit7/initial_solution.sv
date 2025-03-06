module TopModule(
    input logic clk,
    input logic a,
    output logic q
);

    initial begin
        q = 1'b0; // Initial state of the output
    end

    always @(posedge clk) begin
        if (a) begin
            q <= ~q; // Toggle q if a is high
        end
        // No state change if a is low
    end

endmodule