module TopModule (
    input logic clk,
    input logic reset,
    input logic cpu_overheated,
    input logic arrived,
    input logic gas_tank_empty,
    output logic shut_off_computer,
    output logic keep_driving
);

    logic shut_off_computer_next;
    logic keep_driving_next;

    always @(*) begin
        shut_off_computer_next = cpu_overheated || gas_tank_empty;
        keep_driving_next = arrived ? 1'b0 : ~shut_off_computer_next;
    end

    always @(posedge clk) begin
        if (reset) begin
            shut_off_computer <= 1'b0;
            keep_driving <= 1'b1;
        end else begin
            shut_off_computer <= shut_off_computer_next;
            keep_driving <= keep_driving_next;
        end
    end

endmodule