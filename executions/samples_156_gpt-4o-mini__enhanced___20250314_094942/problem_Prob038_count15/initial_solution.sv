module TopModule (
    input logic clk,          // Clock input (1 bit)
    input logic reset,        // Reset input (1 bit, active high, synchronous)
    output logic [3:0] q     // 4-bit output representing the counter state (unsigned)
);

always @(posedge clk) begin
    if (reset) 
        q <= 4'b0000; 
    else 
        q <= (q == 4'b1111) ? 4'b0000 : q + 1;
end

endmodule