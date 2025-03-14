module TopModule (
    input      cpu_overheated,
    input      arrived,
    input      gas_tank_empty,
    output reg shut_off_computer,
    output reg keep_driving
);

    always @(*) begin
        if (cpu_overheated)
            shut_off_computer = 1;
        else
            shut_off_computer = 0;
    end

    always @(*) begin
        if (arrived || gas_tank_empty)
            keep_driving = 0;
        else
            keep_driving = 1;
    end

endmodule