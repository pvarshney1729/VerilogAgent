module TopModule (
    input logic clk,    // Clock signal, positive edge-triggered
    input logic a,      // 1-bit input signal
    input logic rst_n,  // Active-low synchronous reset
    output logic q      // 1-bit output signal, register type
);

    always @(posedge clk) begin
        if (!rst_n)
            q <= 1'b0;
        else if (a == 1'b0)
            q <= 1'b1;
        else
            q <= 1'b0;
    end

endmodule