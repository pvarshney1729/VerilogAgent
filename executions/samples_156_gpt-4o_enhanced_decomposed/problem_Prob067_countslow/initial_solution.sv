module TopModule(
    input logic clk,
    input logic reset,
    input logic slowena,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset the counter to 0
        end else if (slowena) begin
            if (q == 4'b1001) begin
                q <= 4'b0000; // Wrap around to 0 after reaching 9
            end else begin
                q <= q + 1; // Increment the counter
            end
        end
    end

endmodule