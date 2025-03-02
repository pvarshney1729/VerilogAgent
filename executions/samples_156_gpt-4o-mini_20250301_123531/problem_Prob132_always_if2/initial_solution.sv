module SafetyControl (
    input logic cpu_overheated,    // 1-bit input, active-high, indicating CPU temperature is above safe limits
    input logic arrived,           // 1-bit input, active-high, indicating vehicle has reached its destination
    input logic gas_tank_empty,    // 1-bit input, active-high, indicating the gas tank is empty
    output logic shut_off_computer, // 1-bit output, active-high, controls the computer shutdown state
    output logic keep_driving       // 1-bit output, active-high, controls whether to keep driving
);

    // Initial states
    initial begin
        shut_off_computer = 0;
        keep_driving = 0;
    end

    // Combinational logic for determining the shutdown state of the computer
    always @(*) begin
        // If the CPU is overheated, the computer should be shut down
        if (cpu_overheated) begin
            shut_off_computer = 1;
        end else begin
            shut_off_computer = 0; // Explicit deassertion when the condition is not met
        end
    end

    // Combinational logic for determining the driving state
    always @(*) begin
        // If the vehicle has not arrived, keep driving unless the gas tank is empty
        if (~arrived) begin
            keep_driving = ~gas_tank_empty;
        end else begin
            keep_driving = 0; // Stop driving upon arrival
        end
    end

endmodule