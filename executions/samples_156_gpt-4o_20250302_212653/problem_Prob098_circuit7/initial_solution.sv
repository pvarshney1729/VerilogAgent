module TopModule(
    input wire clk,
    input wire a,
    output reg q
);

    initial begin
        q = 1'b0; // Initial state
    end

    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= ~q; // Toggle state
        end
        // If a is 0, retain the previous state of q
    end

endmodule