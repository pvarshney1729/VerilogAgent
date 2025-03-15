module TopModule(
    input logic clk,
    input logic reset,
    input logic [31:0] in,
    output logic [31:0] out
);

    // Internal signal to store the previous state of the input
    logic [31:0] prev_in;

    // Synchronous logic block for capturing 1-to-0 transitions
    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset output and previous input when reset is asserted
            out <= 32'b0;
            prev_in <= 32'b0;
        end else begin
            // Detect 1-to-0 transitions and set the corresponding output bits
            out <= out | (prev_in & ~in);
            // Update the previous input state
            prev_in <= in;
        end
    end

endmodule