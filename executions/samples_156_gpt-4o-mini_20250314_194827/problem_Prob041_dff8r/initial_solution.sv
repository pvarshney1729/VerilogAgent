module sync_reset (
    input logic [7:0] d,
    input logic clk,
    input logic reset,
    output logic [7:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000;
        end else begin
            q <= d;
        end
    end

endmodule