module TopModule (
    input logic clk,       // Clock signal, positive edge-triggered
    input logic a,         // Single-bit input
    output logic [2:0] q   // 3-bit output, unsigned
);
    
    always @(posedge clk) begin
        if (a) begin
            q <= 3'b100;  // Hold at 4 when a is high
        end else begin
            if (q == 3'b110) begin
                q <= 3'b000;  // Wrap around from 6 to 0
            end else begin
                q <= q + 1;   // Increment when a is low
            end
        end
    end

endmodule