module TopModule (
    input logic cpu_overheated,
    output logic shut_off_computer,
    input logic arrived,
    input logic gas_tank_empty,
    output logic keep_driving
);

    // Combinational logic for shutting off the computer
    always_comb begin
        shut_off_computer = cpu_overheated;
    end

    // Combinational logic for driving decision
    always_comb begin
        keep_driving = ~arrived && ~gas_tank_empty;
    end

endmodule