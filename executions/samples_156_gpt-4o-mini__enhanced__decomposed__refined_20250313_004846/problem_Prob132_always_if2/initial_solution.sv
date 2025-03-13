module TopModule (
    input  logic cpu_overheated,   // Single-bit input: 1 if CPU is overheated, else 0.
    output logic shut_off_computer, // Single-bit output: 1 if computer should be shut off, else 0.
    input  logic arrived,          // Single-bit input: 1 if destination is reached, else 0.
    input  logic gas_tank_empty,   // Single-bit input: 1 if gas tank is empty, else 0.
    output logic keep_driving      // Single-bit output: 1 if should keep driving, else 0.
);

// Combinational logic block for shut_off_computer
always @(*) begin
    // Set shut_off_computer based on cpu_overheated status
    shut_off_computer = cpu_overheated ? 1'b1 : 1'b0;
end

// Combinational logic block for keep_driving
always @(*) begin
    // Set keep_driving based on whether arrived and gas_tank_empty status
    keep_driving = (~arrived) ? ~gas_tank_empty : 1'b0; // If arrived, no need to keep driving
end

endmodule