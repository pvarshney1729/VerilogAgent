module TopModule (
    input logic cpu_overheated,       // 1-bit input, active-high when CPU is overheated
    output logic shut_off_computer,   // 1-bit output, active-high to shut off computer
    input logic arrived,              // 1-bit input, active-high when destination is arrived
    input logic gas_tank_empty,       // 1-bit input, active-high when gas tank is empty
    output logic keep_driving         // 1-bit output, active-high to keep driving
);

    // Combinational logic for shut_off_computer
    always_comb begin
        if (cpu_overheated) begin
            shut_off_computer = 1'b1; // Shut off the computer if CPU is overheated
        end else begin
            shut_off_computer = 1'b0; // Ensure computer remains on if not overheated
        end
    end

    // Combinational logic for keep_driving
    always_comb begin
        if (!arrived) begin
            if (!gas_tank_empty) begin
                keep_driving = 1'b1;  // Keep driving if not arrived and tank is not empty
            end else begin
                keep_driving = 1'b0;  // Stop driving if tank is empty
            end
        end else begin
            keep_driving = 1'b0;      // Stop driving if arrived
        end
    end

endmodule