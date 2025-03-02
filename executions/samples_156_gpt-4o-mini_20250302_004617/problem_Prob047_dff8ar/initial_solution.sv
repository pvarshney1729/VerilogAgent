module async_reset_flip_flop (
    input logic clk,
    input logic areset,
    input logic d,
    output logic q
);

    always @(posedge clk or negedge areset) begin
        if (!areset) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule