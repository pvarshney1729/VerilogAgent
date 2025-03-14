[BEGIN]
module TopModule(
    input logic mode,          // 1-bit input: 1 for heating mode, 0 for cooling mode
    input logic is_too_cold,  // 1-bit input: 1 if the temperature is too cold
    input logic is_too_hot,    // 1-bit input: 1 if the temperature is too hot
    input logic fan_on,        // 1-bit input: 1 to manually enable the fan
    output logic heater,       // 1-bit output: 1 to turn on the heater
    output logic aircon,       // 1-bit output: 1 to turn on the air conditioner
    output logic fan           // 1-bit output: 1 to turn on the fan
);

    // Combinational logic for heater, air conditioner, and fan
    always @(*) begin
        // Initialize outputs
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        // Heating mode logic
        if (mode == 1'b1) begin
            if (is_too_cold == 1'b1) 
                heater = 1'b1;
            aircon = 1'b0;
        end else begin
            // Cooling mode logic
            if (is_too_hot == 1'b1) 
                aircon = 1'b1;
            heater = 1'b0;
        end

        // Fan control logic
        fan = fan_on || heater || aircon;
    end
endmodule
[DONE]