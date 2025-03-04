module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    always_ff @(posedge clk) begin
        if (a) begin
            q <= q; // Maintain current state
        end else begin
            if (q == 3'd6) begin
                q <= 3'd0; // Wrap around
            end else begin
                q <= q + 3'd1; // Increment
            end
        end
    end

endmodule