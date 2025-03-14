module TopModule (
    input logic cpu_overheated,      // Input signal indicating if the CPU is overheated (1 bit)
    output logic shut_off_computer,   // Output signal to shut off the computer (1 bit)
    input logic arrived,              // Input signal indicating if the vehicle has arrived (1 bit)
    input logic gas_tank_empty,      // Input signal indicating if the gas tank is empty (1 bit)
    output logic keep_driving          // Output signal to indicate if the vehicle should keep driving (1 bit)
);

    // Initial states for the registers
    initial begin
        shut_off_computer = 1'b0;          // Initial state for shut_off_computer
        keep_driving = 1'b0;                // Initial state for keep_driving
    end

    // Combinational Logic for Shutting Off the Computer
    always @(*) begin
        shut_off_computer = cpu_overheated ? 1'b1 : 1'b0;
    end

    // Combinational Logic for Driving Decision
    always @(*) begin
        if (~arrived) begin
            keep_driving = ~gas_tank_empty; // Drive only if the tank is not empty
        end else begin
            keep_driving = 1'b0;             // If arrived, do not keep driving
        end
    end

endmodule