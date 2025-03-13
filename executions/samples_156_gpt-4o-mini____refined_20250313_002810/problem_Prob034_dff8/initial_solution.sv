[BEGIN]
module TopModule (
    input logic clk,
    input logic [7:0] d,
    output logic [7:0] q
);

    always @(posedge clk) begin
        q <= d; // Synchronous assignment on clock edge
    end

endmodule
[DONE]