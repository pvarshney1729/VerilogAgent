[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    logic [7:0] q_int;

    always @(negedge clk) begin
        if (reset) begin
            q_int <= 8'h34; // Reset to 0x34
        end else begin
            q_int <= d; // Load data
        end
    end

    assign q = q_int;

endmodule
[DONE]