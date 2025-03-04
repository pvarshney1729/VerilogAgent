```verilog
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
            tc <= (data == 10'b0);
        end else if (counter != 10'b0) begin
            counter <= counter - 1;
            if (counter == 10'b1)
                tc <= 1;
        end
    end
endmodule
```