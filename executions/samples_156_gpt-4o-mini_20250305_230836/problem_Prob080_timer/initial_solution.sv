```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic [9:0] data,
    input logic reset_n,
    output logic tc
);
    logic [9:0] counter;

    always @(posedge clk) begin
        if (!reset_n) begin
            counter <= 10'b0;
            tc <= 1'b0;
        end else if (load) begin
            counter <= data;
        end else if (counter > 10'b0) begin
            counter <= counter - 10'b1;
        end
    end

    always @(*) begin
        tc = (counter == 10'b0);
    end
endmodule
[DONE]
```