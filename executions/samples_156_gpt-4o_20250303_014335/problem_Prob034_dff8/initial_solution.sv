module TopModule (
    input logic clk,          // Clock input, positive edge-triggered
    input logic reset_n,      // Asynchronous active-low reset
    input logic [7:0] d,      // 8-bit input data bus
    output logic [7:0] q      // 8-bit output data bus
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        q <= 8'b00000000;    // Reset all flip-flops to 0
    end else begin
        q <= d;              // Capture input data on rising edge of clk
    end
end

endmodule