```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic [9:0] data,
    output logic tc
);

    logic [9:0] counter;

    always_ff @(posedge clk) begin
        if (load) begin
            counter <= data;
        end else if (counter > 10'b0) begin
            counter <= counter - 10'b1;
        end
    end

    always_ff @(posedge clk) begin
        if (load && data == 10'b0) begin
            tc <= 1'b1;
        end else if (counter == 10'b0) begin
            tc <= 1'b1;
        end else begin
            tc <= 1'b0;
        end
    end

endmodule
[DONE]
```