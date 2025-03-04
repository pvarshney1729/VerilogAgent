```verilog
module TopModule (
    input wire clk,            // Clock input
    input wire reset,          // Asynchronous active-high reset
    input wire shift_ena,      // Shift enable signal
    input wire count_ena,      // Count enable signal
    input wire data,           // Input data for shifting
    output reg [3:0] q         // 4-bit shift register output
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 4'b0000;
    end else begin
        if (shift_ena && !count_ena) begin
            q <= {q[2:0], data};  // Shift left
        end else if (count_ena && !shift_ena) begin
            if (q != 4'b0000) begin
                q <= q - 1;  // Decrement
            end
        end
        // If both shift_ena and count_ena are high, no operation is performed
    end
end

endmodule
```