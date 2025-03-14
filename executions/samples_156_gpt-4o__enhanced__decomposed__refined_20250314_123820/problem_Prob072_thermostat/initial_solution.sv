module TopModule (
    input logic mode,
    input logic too_cold,
    input logic too_hot,
    input logic fan_on,
    output logic heater,
    output logic aircon,
    output logic fan
);

    always @(*) begin
        // Initialize outputs
        heater = 1'b0;
        aircon = 1'b0;
        fan = 1'b0;

        // Heating mode
        if (mode) begin
            if (too_cold) begin
                heater = 1'b1;
            end
            fan = heater || fan_on;
        end
        // Cooling mode
        else begin
            if (too_hot) begin
                aircon = 1'b1;
            end
            fan = aircon || fan_on;
        end
    end

endmodule