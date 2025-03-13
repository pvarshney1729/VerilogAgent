module TopModule (
    input logic cpu_overheated,      // Assumed single-bit, active-high
    output logic shut_off_computer,   // Initial state and active level defined
    input logic arrived,             // Assumed single-bit, active-high
    input logic gas_tank_empty,      // Assumed single-bit, active-high
    output logic keep_driving         // Initial state and active level defined
);

// Initial values for outputs to ensure known state upon startup
initial begin
    shut_off_computer = 1'b0;       // Assume inactive state is '0'
    keep_driving = 1'b0;            // Assume inactive state is '0'
end

// Combinational logic for shutting off the computer
always @(*) begin
    if (cpu_overheated)
        shut_off_computer = 1'b1;   // Active-high signal
    else
        shut_off_computer = 1'b0;   // Ensure clear inactive state
end

// Combinational logic for keeping the car driving
always @(*) begin
    if (~arrived)
        keep_driving = ~gas_tank_empty; // Drive only if not arrived and gas is not empty
    else
        keep_driving = 1'b0;        // Stop driving if arrived
end

endmodule