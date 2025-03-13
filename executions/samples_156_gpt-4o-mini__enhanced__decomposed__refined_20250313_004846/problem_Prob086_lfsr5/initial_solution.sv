[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Active-high synchronous reset
        end else begin
            q <= {q[0] ^ q[2], q[4:1]}; // Feedback and shift
        end
    end

endmodule
[DONE]