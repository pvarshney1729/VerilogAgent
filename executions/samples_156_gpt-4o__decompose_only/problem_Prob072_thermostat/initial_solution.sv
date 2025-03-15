module TopModule(
    input logic mode,
    input logic too_cold,
    input logic too_hot,
    input logic fan_on,
    output logic heater,
    output logic aircon,
    output logic fan
);

    always @(*) begin
        // Default outputs
        heater = 0;
        aircon = 0;
        fan = 0;

        if (mode) begin
            // Heating mode
            if (too_cold) begin
                heater = 1;
                fan = 1;
            end
        end else begin
            // Cooling mode
            if (too_hot) begin
                aircon = 1;
                fan = 1;
            end
        end

        // Fan control
        if (fan_on) begin
            fan = 1;
        end
    end

endmodule