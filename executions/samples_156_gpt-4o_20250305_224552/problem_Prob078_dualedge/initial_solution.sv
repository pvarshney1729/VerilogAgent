```verilog
module TopModule (
    input logic clk,
    input logic rst, // Synchronous reset
    input logic d,
    output logic q
);

    logic temp_q_pos, temp_q_neg;

    // Rising edge capture
    always @(posedge clk) begin
        if (rst) begin
            temp_q_pos <= 1'b0;
        end else begin
            temp_q_pos <= d;
        end
    end

    // Falling edge capture
    always @(negedge clk) begin
        if (rst) begin
            temp_q_neg <= 1'b0;
        end else begin
            temp_q_neg <= d;
        end
    end

    // Combine results to simulate dual-edge behavior
    always @(posedge clk or negedge clk) begin
        if (rst) begin
            q <= 1'b0;
        end else begin
            q <= temp_q_pos | temp_q_neg;
        end
    end

endmodule
```