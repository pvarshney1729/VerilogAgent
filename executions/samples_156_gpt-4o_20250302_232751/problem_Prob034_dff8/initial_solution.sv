module TopModule (
    input logic clk,               // Clock input, triggers on positive edge
    input logic rst_n,             // Active low synchronous reset
    input logic [7:0] d,           // 8-bit data input, bit[0] is the LSB
    output logic [7:0] q           // 8-bit data output, bit[0] is the LSB
);

    always @(posedge clk) begin
        if (!rst_n) begin
            q <= 8'b00000000;      // Reset output to zero
        end else begin
            q <= d;               // On the rising edge of the clock, latch the input 'd' to output 'q'
        end
    end

endmodule