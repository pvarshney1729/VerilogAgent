module TopModule (
    input logic clk,  // Clock signal input
    input logic d,    // Data input
    output logic q    // Data output
);

    // D Flip-Flop behavior: captures 'd' on rising edge of 'clk'
    always_ff @(posedge clk) begin
        q <= d;
    end

endmodule