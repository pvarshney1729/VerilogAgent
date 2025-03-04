module TopModule (
    input logic cpu_overheated,        // 1-bit input, indicates if the CPU is overheated
    input logic arrived,               // 1-bit input, indicates if destination is reached
    input logic gas_tank_empty,        // 1-bit input, indicates if the gas tank is empty
    output logic shut_off_computer,    // 1-bit output, controls computer shut off
    output logic keep_driving          // 1-bit output, controls if the vehicle should keep driving
);

    // Combinational logic to determine computer shut off
    always_comb begin
        if (cpu_overheated) begin
            shut_off_computer = 1'b1;    // If CPU is overheated, shut off the computer
        end else begin
            shut_off_computer = 1'b0;    // Otherwise, keep the computer running
        end
    end

    // Combinational logic to determine driving status
    always_comb begin
        if (~arrived) begin
            keep_driving = ~gas_tank_empty; // If not arrived, keep driving if gas tank is not empty
        end else begin
            keep_driving = 1'b0;         // If arrived, do not keep driving regardless of gas tank status
        end
    end

endmodule