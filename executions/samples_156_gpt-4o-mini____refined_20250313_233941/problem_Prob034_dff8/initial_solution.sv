[BEGIN]
module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [7:0] d,
    output logic [7:0] q
);

    always @(posedge clk) begin
        if (!rst_n) begin
            q <= 8'b0; // Synchronous reset to 0
        end else begin
            q <= d; // Synchronous assignment
        end
    end

endmodule
[DONE]