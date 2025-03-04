module SafetyControl (
    input logic cpu_overheated,     // Indicates if the CPU is overheated
    output logic shut_off_computer, // Controls whether the computer should shut off
    input logic arrived,            // Indicates if the destination has been reached
    input logic gas_tank_empty,     // Indicates if the gas tank is empty
    output logic keep_driving       // Controls whether to continue driving
);

    // Combinational logic block with explicit default assignments
    always @(*) begin
        // Default assignments to prevent latches
        shut_off_computer = 1'b0;
        keep_driving = 1'b0;

        // Logic to determine if the computer should be shut off
        if (cpu_overheated) begin
            shut_off_computer = 1'b1;
        end
        
        // Logic to determine if the vehicle should keep driving
        if (~arrived) begin
            keep_driving = ~gas_tank_empty;
        end
    end

endmodule