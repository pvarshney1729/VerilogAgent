module TopModule (
    input wire clk,                // Clock signal
    input wire areset,             // Asynchronous reset, active high
    input wire load,               // Load enable, active high
    input wire ena,                // Shift enable, active high
    input wire [3:0] data,         // 4-bit data input
    output reg [3:0] q             // 4-bit shift register output
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        q <= 4'b0000;
    end else if (load) begin
        q <= data;
    end else if (ena) begin
        q <= {1'b0, q[3:1]};
    end
end

endmodule