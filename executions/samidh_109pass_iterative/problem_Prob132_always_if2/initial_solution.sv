module ComputerVehicleControl (
    input logic cpu_overheated,
    input logic arrived,
    input logic gas_tank_empty,
    output logic shut_off_computer,
    output logic keep_driving
);

    always_comb begin
        // Default state
        shut_off_computer = 1'b0;
        keep_driving = 1'b0;

        // Control logic
        if (cpu_overheated) begin
            shut_off_computer = 1'b1;
        end
        
        if (~arrived) begin
            keep_driving = ~gas_tank_empty;
        end
    end

endmodule