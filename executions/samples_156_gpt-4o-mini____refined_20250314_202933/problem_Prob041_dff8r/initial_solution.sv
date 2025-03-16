[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000; // Synchronous reset
        end else begin
            q <= d; // Update q with d
        end
    end

endmodule
[DONE]