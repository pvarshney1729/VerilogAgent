module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset counter to 0
        end else begin
            if (q < 4'b1111) begin
                q <= q + 1; // Increment counter
            end else begin
                q <= 4'b0000; // Wrap around to 0
            end
        end
    end

endmodule