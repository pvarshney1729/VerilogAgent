module TopModule (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving
);

    // Combinational logic to determine if the computer should be shut off
    always @(*) begin
        shut_off_computer = 1'b0; // Default to off
        if (cpu_overheated) begin
            shut_off_computer = 1'b1; // Set to 1 if CPU is overheated
        end
    end

    // Combinational logic to determine if we should keep driving
    always @(*) begin
        keep_driving = 1'b0; // Default to not driving
        if (~arrived) begin
            keep_driving = ~gas_tank_empty; // Keep driving if gas tank is not empty
        end
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly