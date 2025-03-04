module TopModule (
    input  wire clk,         // 1-bit clock input signal
    input  wire w,           // 1-bit data input from the previous stage
    input  wire R,           // 1-bit data input for loading a specific value
    input  wire E,           // 1-bit enable signal for shifting
    input  wire L,           // 1-bit load signal for loading the value R into Q
    output reg  Q            // 1-bit output to the next stage of the shift register
);

    always @(posedge clk) begin
        if (L) begin
            Q <= R;
        end else if (E) begin
            Q <= w;
        end
    end

endmodule