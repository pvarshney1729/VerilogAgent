module AdderSubtractorWithZeroFlag (
    input logic cpu_overheated,      // Input indicating if the CPU is overheated
    input logic arrived,             // Input indicating if the destination is reached
    input logic gas_tank_empty,      // Input indicating if the gas tank is empty
    output logic shut_off_computer,  // Output to shut off the computer
    output logic keep_driving        // Output to keep driving
);

    // Combinational logic block for controlling the computer's shut-off
    always_comb begin
        if (cpu_overheated) begin
            shut_off_computer = 1'b1;  // Shut off the computer if CPU is overheated
        end else begin
            shut_off_computer = 1'b0;  // Ensure the computer stays on otherwise
        end
    end

    // Combinational logic block for controlling the driving state
    always_comb begin
        if (~arrived) begin
            keep_driving = gas_tank_empty ? 1'b0 : 1'b1; // Keep driving if not arrived and gas is not empty
        end else begin
            keep_driving = 1'b0;            // Stop driving if arrived
        end
    end

endmodule