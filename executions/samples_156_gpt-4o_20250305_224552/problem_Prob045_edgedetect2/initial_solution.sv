```verilog
module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    logic [7:0] prev_in;

    // Asynchronous reset logic
    always_ff @(posedge clk) begin
        if (!reset) begin
            prev_in <= 8'b0;
            anyedge <= 8'b0;
        end else begin
            anyedge <= (in ^ prev_in);
            prev_in <= in;
        end
    end

endmodule
```