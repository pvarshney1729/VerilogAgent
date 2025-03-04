module TopModule (
    input logic clk,        // Clock input, active on rising edge
    input logic a,          // 1-bit input signal
    output logic [2:0] q    // 3-bit output signal, unsigned
);

    always_ff @(posedge clk) begin
        if (a == 1'b1) begin
            q <= 3'b100;  // Maintain value 4
        end else begin
            q <= q + 1;   // Increment q
        end
    end

endmodule