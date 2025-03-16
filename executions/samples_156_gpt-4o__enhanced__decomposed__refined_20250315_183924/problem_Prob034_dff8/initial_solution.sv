[BEGIN]
module TopModule (
    input logic clk,
    input logic rst_n,          // Asynchronous active-low reset
    input logic [7:0] d,
    output logic [7:0] q
);

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q <= 8'b00000000;   // Reset q to 0 when rst_n is low
        end else begin
            q <= d;             // Capture d into q on the rising edge of clk
        end
    end

endmodule
[DONE]