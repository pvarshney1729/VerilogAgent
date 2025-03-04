```verilog
module SafeDrivingControl (
    input logic cpu_overheated,       // Input signal indicating CPU temperature status
    input logic arrived,              // Input signal indicating arrival status
    input logic gas_tank_empty,       // Input signal indicating gas tank status
    output logic shut_off_computer,    // Output signal to shut off the computer
    output logic keep_driving          // Output signal to continue driving
);

    // Combinational logic block for shut_off_computer
    always @(*) begin
        shut_off_computer = cpu_overheated; // Shut off computer if CPU is overheated
    end

    // Combinational logic block for keep_driving
    always @(*) begin
        keep_driving = ~arrived & ~gas_tank_empty; // Continue driving if not arrived and gas tank is not empty
    end

endmodule
```