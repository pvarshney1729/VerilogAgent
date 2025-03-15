module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic [31:0] in,
    output logic [31:0] out
);

    logic [31:0] in_prev; // To store the previous state of 'in'

    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0; // Reset output to 0
            in_prev <= 32'b0; // Reset previous state of 'in'
        end else begin
            in_prev <= in; // Store the current state of 'in'

            // Check for transitions from 1 to 0
            out <= (in_prev & ~in) | out; // Capture transitions, maintain current output
        end
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly