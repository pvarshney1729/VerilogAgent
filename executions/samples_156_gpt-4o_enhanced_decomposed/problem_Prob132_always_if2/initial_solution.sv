module TopModule (
    input logic cpu_overheated,
    output logic shut_off_computer,
    input logic arrived,
    input logic gas_tank_empty,
    output logic keep_driving
);

    always @(*) begin
        // Default value to prevent latches
        shut_off_computer = 0;
        if (cpu_overheated)
            shut_off_computer = 1;
    end

    always @(*) begin
        // Default value to prevent latches
        keep_driving = 0;
        if (~arrived)
            keep_driving = ~gas_tank_empty;
    end

endmodule