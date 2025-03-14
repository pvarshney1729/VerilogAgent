module TopModule (
    input logic clk,               // Clock signal (1 bit, active high)
    input logic areset,            // Asynchronous reset signal (1 bit, active high)
    input logic [7:0] d,           // 8-bit data input (unsigned)
    output logic [7:0] q           // 8-bit data output (unsigned)
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        q <= 8'b00000000; // Reset all flip-flops to 0
    end else begin
        q <= d; // On rising edge of clk, transfer data from d to q
    end
end

endmodule