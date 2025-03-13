[BEGIN]
module TopModule (
    input logic mode,           // Operating mode: 1 = heating, 0 = cooling
    input logic too_cold,      // Temperature status: 1 = too cold, 0 = not too cold
    input logic too_hot,       // Temperature status: 1 = too hot, 0 = not too hot
    input logic fan_on,        // Fan control: 1 = fan requested on, 0 = fan requested off
    output logic heater,        // Heater control: 1 = heater on, 0 = heater off
    output logic aircon,        // Air conditioner control: 1 = air conditioner on, 0 = air conditioner off
    output logic fan            // Fan control: 1 = fan on, 0 = fan off
);

initial begin
    heater = 1'b0;
    aircon = 1'b0;
    fan = 1'b0;
end

always @(*) begin
    case (mode)
        1'b1: begin // Heating mode
            heater = too_cold; // Turn on heater if too cold
            aircon = 1'b0; // Air conditioner must be off
            fan = heater | fan_on; // Fan on if heater is on or fan is requested
        end
        1'b0: begin // Cooling mode
            heater = 1'b0; // Heater must be off
            aircon = too_hot; // Turn on air conditioner if too hot
            fan = aircon | fan_on; // Fan on if aircon is on or fan is requested
        end
        default: begin
            heater = 1'b0;
            aircon = 1'b0;
            fan = 1'b0; // Default condition
        end
    endcase
end

endmodule
[DONE]