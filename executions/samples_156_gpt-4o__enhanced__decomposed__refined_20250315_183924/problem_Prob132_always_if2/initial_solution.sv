module TopModule (
    input logic  cpu_overheated,      // Input signal indicating CPU overheating
    input logic  arrived,             // Input signal indicating arrival status
    input logic  gas_tank_empty,      // Input signal indicating if the gas tank is empty
    output logic shut_off_computer,   // Output to shut off the computer
    output logic keep_driving         // Output to keep driving
);

    // Combinational logic for shut_off_computer
    always @(*) begin
        if (cpu_overheated)
            shut_off_computer = 1; // Shut off computer if CPU is overheated
        else
            shut_off_computer = 0; // Otherwise, do not shut off
    end

    // Combinational logic for keep_driving
    always @(*) begin
        if (~arrived) begin
            keep_driving = ~gas_tank_empty; // Keep driving if not arrived and the gas tank is not empty
        end else begin
            keep_driving = 0; // Stop driving if arrived
        end
    end

endmodule