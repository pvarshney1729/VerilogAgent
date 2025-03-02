```verilog
module bcd_counter (
    input logic clk,
    input logic reset,
    input logic [2:0] ena,
    output logic [3:0] digit0,
    output logic [3:0] digit1,
    output logic [3:0] digit2
);

    // Synchronous reset and enable logic for digit0
    always_ff @(posedge clk) begin
        if (reset) begin
            digit0 <= 4'd0;
        end else if (ena[0]) begin
            if (digit0 == 4'd9) begin
                digit0 <= 4'd0;
            end else begin
                digit0 <= digit0 + 4'd1;
            end
        end
    end

    // Synchronous reset and enable logic for digit1
    always_ff @(posedge clk) begin
        if (reset) begin
            digit1 <= 4'd0;
        end else if (ena[1] && digit0 == 4'd9) begin
            if (digit1 == 4'd9) begin
                digit1 <= 4'd0;
            end else begin
                digit1 <= digit1 + 4'd1;
            end
        end
    end

    // Synchronous reset and enable logic for digit2
    always_ff @(posedge clk) begin
        if (reset) begin
            digit2 <= 4'd0;
        end else if (ena[2] && digit0 == 4'd9 && digit1 == 4'd9) begin
            if (digit2 == 4'd9) begin
                digit2 <= 4'd0;
            end else begin
                digit2 <= digit2 + 4'd1;
            end
        end
    end

endmodule
```