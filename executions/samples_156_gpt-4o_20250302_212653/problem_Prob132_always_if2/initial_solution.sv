module TopModule (
    input logic cpu_overheated,   // Indicates if the CPU is overheated
    input logic arrived,          // Indicates if the destination has been reached
    input logic gas_tank_empty,   // Indicates if the gas tank is empty
    output logic shut_off_computer, // Output signal to shut off the computer
    output logic keep_driving       // Output signal to continue driving
);

    // Combinational logic for shutting off the computer
    always_comb begin
        if (cpu_overheated) begin
            shut_off_computer = 1'b1; // Shut off computer if CPU is overheated
        end else begin
            shut_off_computer = 1'b0; // Do not shut off computer if CPU is not overheated
        end
    end

    // Combinational logic for driving behavior
    always_comb begin
        if (~arrived) begin
            keep_driving = ~gas_tank_empty; // Continue driving if not arrived and gas tank is not empty
        end else begin
            keep_driving = 1'b0; // Stop driving if arrived
        end
    end

endmodule