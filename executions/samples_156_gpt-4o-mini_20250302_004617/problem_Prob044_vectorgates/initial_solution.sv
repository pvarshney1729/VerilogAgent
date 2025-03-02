module TopModule (
    input logic [2:0] a,
    input logic [2:0] b,
    input logic clk,
    input logic reset,
    output logic [2:0] out_or_bitwise,
    output logic out_or_logical,
    output logic [2:0] out_not
);

    // Combinational logic for bitwise OR
    assign out_or_bitwise = a | b;

    // Combinational logic for logical OR
    assign out_or_logical = |(a | b);

    // Combinational logic for NOT operation
    assign out_not = ~a;

    // Sequential logic with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            // Initialize outputs to zero on reset
            out_or_bitwise <= 3'b000;
            out_or_logical <= 1'b0;
            out_not <= 3'b000;
        end
    end

endmodule