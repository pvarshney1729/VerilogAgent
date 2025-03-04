module SystemControl (
    input logic cpu_overheated, // 1-bit input: Indicates if the CPU is overheated
    input logic arrived,        // 1-bit input: Indicates whether the destination is arrived
    input logic gas_tank_empty, // 1-bit input: Indicates if the gas tank is empty
    output logic shut_off_computer, // 1-bit output: Signal to shut off the computer
    output logic keep_driving    // 1-bit output: Signal to keep driving
);

// Combinational Logic
// Ensure outputs are always assigned to avoid latches
assign shut_off_computer = (cpu_overheated) ? 1'b1 : 1'b0; // Set to 1 when CPU is overheated

assign keep_driving = (~arrived) ? ~gas_tank_empty : 1'b0; // Drive if not arrived and gas tank is not empty

endmodule