module TopModule (
    input logic clk,         // Clock signal, active on the rising edge
    input logic reset,       // Active-high synchronous reset
    output logic [4:0] q     // 5-bit output representing the LFSR state
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001;  // Initialize to 1 on reset
        end else begin
            q[4] <= q[0] ^ q[4] ^ q[2]; // New bit calculation
            q[3] <= q[4];               // Shift right
            q[2] <= q[3];               // Shift right
            q[1] <= q[2];               // Shift right
            q[0] <= q[1];               // Shift right
        end
    end

endmodule