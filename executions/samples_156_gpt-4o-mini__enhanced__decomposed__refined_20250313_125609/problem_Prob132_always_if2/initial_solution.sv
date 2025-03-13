[BEGIN]
module TopModule (
    input logic cpu_overheated,
    output logic shut_off_computer,
    input logic arrived,
    input logic gas_tank_empty,
    output logic keep_driving
);

initial begin
    shut_off_computer = 1'b0;
    keep_driving = 1'b0;
end

always @(*) begin
    if (cpu_overheated) begin
        shut_off_computer = 1'b1;
    end else begin
        shut_off_computer = 1'b0;
    end
end

always @(*) begin
    if (arrived) begin
        keep_driving = 1'b0;
    end else begin
        keep_driving = ~gas_tank_empty;
    end
end

endmodule
[DONE]