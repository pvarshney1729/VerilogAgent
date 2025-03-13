[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] prev_in;

    always @(posedge clk) begin
        if (reset) begin
            pedge <= 8'b00000000;
            prev_in <= 8'b00000000;
        end else begin
            pedge <= (~prev_in & in); // Detect 0 to 1 transition
            prev_in <= in;            // Store current input state
        end
    end

endmodule
[DONE]