module TopModule (
    input wire clk,        // Clock signal for synchronous operations
    input wire reset,      // Asynchronous active-high reset
    input wire load,       // Active-high load signal
    input wire ena,        // Active-high enable signal for shifting
    input wire [1:0] amount,  // 2-bit signal to determine shift direction and amount
    input wire [63:0] data,   // 64-bit input data for loading
    output reg [63:0] q       // 64-bit output register, contents of the shifter
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 64'b0;
    end else begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;
                2'b01: q <= q << 8;
                2'b10: q <= $signed(q) >>> 1;
                2'b11: q <= $signed(q) >>> 8;
                default: q <= q;
            endcase
        end
    end
end

endmodule