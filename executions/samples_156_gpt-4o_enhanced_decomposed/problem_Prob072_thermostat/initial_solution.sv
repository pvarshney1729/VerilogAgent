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
        // Heater control logic
        heater = mode & too_cold;
        
        // Air conditioner control logic
        aircon = ~mode & too_hot;
        
        // Fan control logic
        fan = heater | aircon | fan_on;
    end

endmodule