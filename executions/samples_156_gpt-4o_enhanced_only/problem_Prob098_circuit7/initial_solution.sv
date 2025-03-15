module TopModule(
    input logic clk,
    input logic a,
    output logic q
);

    // Initial state of q is undefined, but we assume it's initialized to 1
    initial begin
        q = 1'b1;
    end

    // Sequential logic block triggered on the rising edge of clk
    always_ff @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 1'b0; // Set q to 0 when a is 1
        end
    end

endmodule