module TopModule (
    input logic clk,  // Clock input
    input logic d,    // Data input
    input logic r,    // Synchronous reset input
    output logic q    // Output
);
    always @(*) begin
        if (r) begin
            q <= 1'b0;  // Reset output to 0
        end else begin
            q <= d;     // Sample data input on rising edge
        end
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly