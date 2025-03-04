module TopModule (
    input logic clk,                   // Clock signal
    input logic load,                  // Synchronous load signal, active high
    input logic [511:0] data,          // 512-bit input data for loading state
    output logic [511:0] q             // 512-bit output representing current state
);

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            logic [511:0] next_q;
            for (int i = 0; i < 512; i++) begin
                logic left = (i < 511) ? q[i+1] : 1'b0;
                logic right = (i > 0) ? q[i-1] : 1'b0;
                logic center = q[i];
                
                next_q[i] = (left & center & right) ? 1'b0 :
                            (left & center & ~right) ? 1'b1 :
                            (left & ~center & right) ? 1'b1 :
                            (left & ~center & ~right) ? 1'b0 :
                            (~left & center & right) ? 1'b1 :
                            (~left & center & ~right) ? 1'b1 :
                            (~left & ~center & right) ? 1'b1 :
                            1'b0;
            end
            q <= next_q;
        end
    end

endmodule