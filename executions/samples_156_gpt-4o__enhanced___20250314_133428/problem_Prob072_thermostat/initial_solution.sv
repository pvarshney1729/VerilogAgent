module TopModule (
    input logic mode,          // 1-bit input: 1 = heating mode, 0 = cooling mode
    input logic too_cold,      // 1-bit input: 1 = temperature is too cold
    input logic too_hot,       // 1-bit input: 1 = temperature is too hot
    input logic fan_on,        // 1-bit input: 1 = user requests fan on
    output logic heater,       // 1-bit output: heater control
    output logic aircon,       // 1-bit output: air conditioner control
    output logic fan           // 1-bit output: fan control
);

    always @(*) begin
        // Initialize outputs
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        if (mode) begin
            // Heating mode
            if (too_cold) begin
                heater = 1'b1;
            end
        end else begin
            // Cooling mode
            if (too_hot) begin
                aircon = 1'b1;
            end
        end

        // Fan control
        if (heater || aircon || fan_on) begin
            fan = 1'b1;
        end
    end

endmodule