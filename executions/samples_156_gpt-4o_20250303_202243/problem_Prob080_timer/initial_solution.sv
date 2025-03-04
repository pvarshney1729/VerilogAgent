```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic load,
    input logic [9:0] data,
    output logic tc
);
    logic [9:0] counter;

    // Synchronous reset and counter logic
    always @(posedge clk) begin
        if (reset) begin
            counter <= 10'b0;
            tc <= 1'b0;
        end else if (load) begin
            if (data != 10'b0) begin
                counter <= data;
                tc <= 1'b0;
            end else begin
                counter <= 10'b0;
                tc <= 1'b1;
            end
        end else if (counter != 10'b0) begin
            counter <= counter - 1'b1;
            tc <= (counter == 10'b1) ? 1'b1 : 1'b0;
        end
    end
endmodule
```