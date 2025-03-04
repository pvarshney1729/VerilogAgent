module TopModule (
    input logic cpu_overheated,     // 1-bit input indicating if the CPU is overheated
    input logic arrived,            // 1-bit input indicating if the destination has been arrived
    input logic gas_tank_empty,     // 1-bit input indicating if the gas tank is empty
    output logic shut_off_computer,  // 1-bit output to shut off the computer
    output logic keep_driving        // 1-bit output to keep driving
);

always @(*) begin
    // Default output values to prevent latch inference
    shut_off_computer = 1'b0;
    keep_driving = 1'b0;
    
    // Shut off the computer if the CPU is overheated
    if (cpu_overheated) begin
        shut_off_computer = 1'b1;
    end

    // Determine whether to keep driving based on arrival and gas status
    if (!arrived) begin
        keep_driving = ~gas_tank_empty;  // Keep driving if not arrived and gas tank is not empty
    end
end

endmodule