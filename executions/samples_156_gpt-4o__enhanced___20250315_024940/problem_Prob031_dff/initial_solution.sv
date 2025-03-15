module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

    // Flip-flop behavior: On the rising edge of clk, assign d to q
    always @(posedge clk) begin
        q <= d;
    end

endmodule