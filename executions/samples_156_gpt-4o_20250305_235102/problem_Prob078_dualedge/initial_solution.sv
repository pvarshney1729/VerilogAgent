```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic rst_n,
    input logic d,
    output logic q
);

    logic d_rising, d_falling;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            d_rising <= 1'b0;
        end else begin
            d_rising <= d;
        end
    end

    always_ff @(negedge clk) begin
        if (!rst_n) begin
            d_falling <= 1'b0;
        end else begin
            d_falling <= d;
        end
    end

    always_comb begin
        q = (d_rising || d_falling);
    end

endmodule
[DONE]
```