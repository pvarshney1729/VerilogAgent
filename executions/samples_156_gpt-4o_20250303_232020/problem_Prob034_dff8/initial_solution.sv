module TopModule (
    input wire clk,
    input wire rst_n,  // Asynchronous active-low reset
    input wire [7:0] d,
    output reg [7:0] q
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 8'b00000000;  // Reset state
    else
        q <= d;  // Capture input on the rising edge
end

endmodule