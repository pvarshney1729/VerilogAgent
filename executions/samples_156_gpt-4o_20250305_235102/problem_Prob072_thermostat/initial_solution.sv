```verilog
[BEGIN]
module TopModule (
    input  logic mode,
    input  logic too_cold,
    input  logic too_hot,
    input  logic fan_on,
    output logic heater,
    output logic aircon,
    output logic fan
);

    always @(*) begin
        // Initialize outputs
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        // Mode selection logic
        if (mode == 1'b1) begin
            // Heating mode
            if (too_cold == 1'b1) begin
                heater = 1'b1;
            end
        end else begin
            // Cooling mode
            if (too_hot == 1'b1) begin
                aircon = 1'b1;
            end
        end

        // Fan control logic
        if (heater == 1'b1 || aircon == 1'b1 || fan_on == 1'b1) begin
            fan = 1'b1;
        end
    end

endmodule
[DONE]
```