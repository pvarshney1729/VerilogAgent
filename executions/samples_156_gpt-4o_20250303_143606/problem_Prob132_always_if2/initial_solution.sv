module TopModule (
    input  logic cpu_overheated,
    output logic shut_off_computer,
    input  logic arrived,
    input  logic gas_tank_empty,
    output logic keep_driving
);

    // Combinational logic for shutting off the computer
    always_comb begin
        shut_off_computer = cpu_overheated ? 1'b1 : 1'b0;
    end

    // Combinational logic for keeping driving
    always_comb begin
        if (~arrived)
            keep_driving = ~gas_tank_empty;
        else
            keep_driving = 1'b0;
    end

endmodule