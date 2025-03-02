```verilog
module ringer_motor_control (
    input logic clk,
    input logic reset,
    input logic ring,
    input logic vibrate_mode,
    output logic ringer,
    output logic motor
);

    // Sequential logic for synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            ringer <= 1'b0;
            motor <= 1'b0;
        end else begin
            // Combinational logic to ensure mutual exclusivity
            if (ring && !vibrate_mode) begin
                ringer <= 1'b1;
                motor <= 1'b0;
            end else if (ring && vibrate_mode) begin
                ringer <= 1'b0;
                motor <= 1'b1;
            end else begin
                ringer <= 1'b0;
                motor <= 1'b0;
            end
        end
    end

endmodule
```