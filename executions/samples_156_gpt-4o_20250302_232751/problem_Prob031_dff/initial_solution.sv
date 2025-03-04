module TopModule (
    input logic clk,    // Clock input, positive edge triggered
    input logic d,      // Data input for the D flip-flop
    output logic q      // Data output, captures the value of d on rising clock edge
);

    always @(posedge clk) begin
        q <= d;
    end

endmodule