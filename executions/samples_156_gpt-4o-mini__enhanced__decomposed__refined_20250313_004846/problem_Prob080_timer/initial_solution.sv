```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic reset,
    input logic [9:0] data,
    output logic tc
);

    logic [9:0] counter;
    logic tc_ff;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 10'b0;
            tc_ff <= 1'b0;
        end else if (load) begin
            counter <= data;
            tc_ff <= (data == 10'b0) ? 1'b1 : 1'b0;
        end else if (counter != 10'b0) begin
            counter <= counter - 10'b1;
            tc_ff <= (counter == 10'b1);
        end else begin
            tc_ff <= 1'b0; // Ensure tc_ff is reset when counter is 0
        end
    end

    assign tc = tc_ff;

endmodule
[DONE]
```