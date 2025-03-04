module TopModule (
    input  logic        clk,    // Clock signal (positive edge-triggered)
    input  logic [7:0]  d,      // 8-bit data input (unsigned, d[0] is LSB)
    output logic [7:0]  q       // 8-bit data output (unsigned, q[0] is LSB)
);

    always @(posedge clk) begin
        q <= d;
    end

endmodule