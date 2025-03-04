module TopModule (
    input  logic clk,            // Clock input (positive edge-triggered)
    input  logic areset,         // Asynchronous reset input (active high)
    input  logic [7:0] d,        // 8-bit input data bus
    output logic [7:0] q         // 8-bit output data bus
);

// D Flip-Flops with asynchronous reset
always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Active high asynchronous reset: Set output to all zeroes
        q <= 8'b00000000;
    end else begin
        // Capture input data on the positive edge of the clock
        q <= d;
    end
end

endmodule