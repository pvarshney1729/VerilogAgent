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
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        if (mode) begin
            // Heating Mode
            if (too_cold) begin
                heater = 1'b1;
            end
            if (heater || fan_on) begin
                fan = 1'b1;
            end
        end else begin
            // Cooling Mode
            if (too_hot) begin
                aircon = 1'b1;
            end
            if (aircon || fan_on) begin
                fan = 1'b1;
            end
        end
    end

endmodule