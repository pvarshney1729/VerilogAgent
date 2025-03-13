[BEGIN]
module TopModule (
    input logic clk,            // Clock signal (active high)
    input logic L,              // Load signal (active high)
    input logic [2:0] r_in,     // 3-bit input data (used when L is asserted)
    input logic [2:0] q_in,     // 3-bit input data (used when L is low)
    output logic [2:0] Q         // 3-bit output data
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;            // Load r_in into Q when L is high
    end else begin
        Q <= {Q[1] ^ Q[2], Q[0], Q[2]}; // Update Q based on previous state
    end
end

initial begin
    Q = 3'b000; // Initialize Q to 3'b000 on power-up
end

endmodule
[DONE]