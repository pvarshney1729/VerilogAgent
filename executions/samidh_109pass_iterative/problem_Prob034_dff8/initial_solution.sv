module TopModule (
    input logic clk,              // Clock signal, 1-bit, triggering on positive edge
    input logic [7:0] d,          // 8-bit data input, d[0] is the LSB, d[7] is the MSB
    output logic [7:0] q          // 8-bit data output, q[0] is the LSB, q[7] is the MSB
);

    // Sequential logic for capturing input data on the positive edge of clk
    always @(posedge clk) begin
        q <= d;
    end

endmodule