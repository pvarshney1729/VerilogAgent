```verilog
module SafetyControl (
    input logic cpu_overheated,        // Signal indicating if CPU is overheated
    input logic arrived,               // Signal indicating arrival at destination
    input logic gas_tank_empty,        // Signal indicating if the gas tank is empty
    output logic shut_off_computer,    // Signal to shut off the computer
    output logic keep_driving          // Signal to continue driving
);

    // Combinational logic to determine control signals
    always_comb begin
        // Default output values
        shut_off_computer = 1'b0;
        keep_driving = 1'b0;

        // Logic to shut off computer
        if (cpu_overheated) begin
            shut_off_computer = 1'b1;
        end

        // Logic to keep driving
        if (~arrived) begin
            keep_driving = ~gas_tank_empty;
        end
    end

endmodule
```