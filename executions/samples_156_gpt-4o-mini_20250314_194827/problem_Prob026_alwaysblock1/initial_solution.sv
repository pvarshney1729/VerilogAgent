module TopModule (
    input logic a,
    input logic b,
    input logic clk,
    input logic reset,
    output logic y_assign,
    output logic y_always
);

    // Assign statement for AND gate functionality
    assign y_assign = a & b;

    // Combinational always block for AND gate functionality
    always @(*) begin
        y_always = a & b;
    end

    // Synchronous reset implementation
    always @(posedge clk) begin
        if (reset) begin
            y_always <= 1'b0; // Initialize to zero on reset
        end
    end

endmodule