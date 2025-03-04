module TopModule (
    input logic mode,        // 1-bit input: 1 for heating mode, 0 for cooling mode
    input logic too_cold,    // 1-bit input: indicates if it is too cold
    input logic too_hot,     // 1-bit input: indicates if it is too hot
    input logic fan_on,      // 1-bit input: user requests fan on
    output logic heater,     // 1-bit output: controls the heater
    output logic aircon,     // 1-bit output: controls the air conditioner
    output logic fan         // 1-bit output: controls the fan
);

always @(*) begin
    // Default outputs
    heater = 1'b0;
    aircon = 1'b0;

    // Heating mode logic
    if (mode) begin
        if (too_cold) begin
            heater = 1'b1;
        end
    end else begin // Cooling mode logic
        if (too_hot) begin
            aircon = 1'b1;
        end
    end
end

assign fan = heater | aircon | fan_on;

endmodule