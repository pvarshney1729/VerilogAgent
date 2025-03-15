module TopModule (
    input      cpu_overheated,
    output logic shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output logic keep_driving
);

    always @(*) begin
        shut_off_computer = cpu_overheated ? 1'b1 : 1'b0;
    end

    always @(*) begin
        if (~arrived)
            keep_driving = ~gas_tank_empty;
        else
            keep_driving = 1'b0; // Ensure keep_driving is defined when arrived is true
    end

endmodule