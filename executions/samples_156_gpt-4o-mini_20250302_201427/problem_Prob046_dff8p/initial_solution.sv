module TopModule (
    input  logic        clk,    // Clock signal, negative edge-triggered
    input  logic        reset,  // Active high synchronous reset
    input  logic [7:0]  d,      // 8-bit unsigned input data
    output logic [7:0]  q       // 8-bit unsigned output data
);

always @(negedge clk) begin
    if (reset) begin
        q <= 8'b00110100; // Reset to 0x34
    end else begin
        q <= d; // Load input data into output
    end
end

endmodule