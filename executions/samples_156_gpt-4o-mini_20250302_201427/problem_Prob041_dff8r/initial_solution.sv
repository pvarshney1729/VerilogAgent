module TopModule (
    input  logic        clk,    // Clock signal, active on the rising edge
    input  logic        reset,  // Synchronous active-high reset
    input  logic [7:0]  d,      // 8-bit unsigned data input
    output logic [7:0]  q       // 8-bit unsigned data output
);

always @(posedge clk) begin
    if (reset) begin
        q <= 8'b00000000; // Reset output to 0
    end else begin
        q <= d; // Capture input data
    end
end

endmodule