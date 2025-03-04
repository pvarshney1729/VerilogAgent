```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic load,
    input logic [9:0] data,
    output logic tc
);
    logic [9:0] counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 10'd0;
            tc <= 1'b0;
        end else if (load) begin
            counter <= data;
            tc <= (data == 10'd0);
        end else if (counter > 10'd0) begin
            counter <= counter - 10'd1;
            if (counter == 10'd1) begin
                tc <= 1'b1;
            end
        end
    end
endmodule
```