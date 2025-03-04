```verilog
module TopModule (
    input wire cpu_overheated,      // 1-bit input indicating if the CPU is overheated
    output reg shut_off_computer,   // 1-bit output to shut off the computer
    input wire arrived,             // 1-bit input indicating if the destination is reached
    input wire gas_tank_empty,      // 1-bit input indicating if the gas tank is empty
    output reg keep_driving         // 1-bit output to decide whether to keep driving
);

    always @(*) begin
        shut_off_computer = cpu_overheated ? 1'b1 : 1'b0;
    end

    always @(*) begin
        keep_driving = (~arrived && ~gas_tank_empty) ? 1'b1 : 1'b0;
    end

endmodule
```