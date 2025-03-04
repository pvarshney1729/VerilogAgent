module TopModule (
    input wire clk,       // Clock signal for sequential logic
    input wire a,         // 1-bit input signal
    output reg [2:0] q    // 3-bit output with MSB as q[2]
);

    // Sequential logic block
    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100;
        end else begin
            q <= q + 1;
        end
    end

endmodule