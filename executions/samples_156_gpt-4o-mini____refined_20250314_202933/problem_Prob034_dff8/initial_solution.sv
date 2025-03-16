[BEGIN]
module TopModule (
    input  logic clk,
    input  logic [7:0] d,
    output logic [7:0] q
);

    always @(posedge clk) begin
        q <= d; // This is synchronous assignment to q
    end

endmodule
[DONE]