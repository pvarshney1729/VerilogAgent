module TopModule (
   input logic clk,                // Clock signal (assumed edge-triggered)
   input logic [7:0] d,            // 8-bit data input, unsigned
   output logic [7:0] q,           // 8-bit data output, unsigned
   input logic rst_n               // Asynchronous active-low reset
);

   // Module Description:
   // - This module implements 8 D flip-flops that capture the input `d` on the positive edge of the `clk`.
   // - Each flip-flop is asynchronously reset to 0 when `rst_n` is low.

   always_ff @(posedge clk or negedge rst_n) begin
      if (!rst_n)
         q <= 8'b00000000;       // Reset state: all outputs zero
      else
         q <= d;                 // Capture input `d` on clock's rising edge
   end

endmodule