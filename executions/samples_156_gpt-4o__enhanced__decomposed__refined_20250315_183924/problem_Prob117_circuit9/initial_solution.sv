module TopModule(
    input logic clk,       // Clock signal
    input logic a,         // Single-bit input
    output logic [2:0] q   // 3-bit output, unsigned
);

    always @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100; // Hold at '4' when a is high
        end else begin
            if (q == 3'b110) begin
                q <= 3'b000; // Wrap around from '6' to '0'
            end else begin
                q <= q + 1; // Increment q
            end
        end
    end

endmodule