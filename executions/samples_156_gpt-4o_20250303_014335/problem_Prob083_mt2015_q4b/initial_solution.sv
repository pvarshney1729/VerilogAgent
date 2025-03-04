module TopModule (
    input logic clk,   // Clock signal for sequential behavior
    input logic reset, // Asynchronous active-high reset
    input logic x,     // 1-bit input
    input logic y,     // 1-bit input
    output logic z     // 1-bit output
);

always_ff @(posedge clk) begin
    if (reset) begin
        z <= 1'b1;
    end else begin
        z <= (x & y) | (~x & ~y & z);
    end
end

endmodule