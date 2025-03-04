module TopModule (
    input logic clk,           // 1-bit clock signal
    input logic reset,         // 1-bit synchronous reset signal
    input logic shift_ena,     // 1-bit enable for shifting
    input logic count_ena,     // 1-bit enable for counting
    input logic data,          // 1-bit data input for shifting
    output logic [3:0] q       // 4-bit output representing the shift register
);
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Synchronous reset
        end else if (shift_ena && !count_ena) begin
            q <= {data, q[3:1]}; // Shift left, insert data as MSB
        end else if (!shift_ena && count_ena) begin
            q <= q - 1; // Decrement the register
        end
        // If both shift_ena and count_ena are high, the behavior is undefined.
    end
endmodule