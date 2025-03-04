module TopModule (
    input logic cpu_overheated,        // 1-bit input signal indicating CPU overheating
    input logic arrived,               // 1-bit input signal indicating arrival at the destination
    input logic gas_tank_empty,        // 1-bit input signal indicating if the gas tank is empty
    output logic shut_off_computer,    // 1-bit output to signal computer shutdown
    output logic keep_driving          // 1-bit output to signal to continue driving
);

    always @(*) begin
        if (cpu_overheated)
            shut_off_computer = 1'b1;
        else
            shut_off_computer = 1'b0;
    end

    always @(*) begin
        if (~arrived && ~gas_tank_empty)
            keep_driving = 1'b1;
        else
            keep_driving = 1'b0;
    end

endmodule