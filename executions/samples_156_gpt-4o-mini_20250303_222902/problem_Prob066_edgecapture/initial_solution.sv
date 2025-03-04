module TopModule (
    input logic clk,
    input logic reset,
    input logic [31:0] in,
    output logic [31:0] out
);
    logic [31:0] prev_in;

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;  // Reset output to 0
        end else begin
            out <= out | (~in & prev_in);  // Capture 1-to-0 transitions
        end
        prev_in <= in;  // Store current input for next cycle comparison
    end
endmodule