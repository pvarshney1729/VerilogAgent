[BEGIN]
module TopModule(
    input logic clk,          // Clock signal, positive edge-triggered
    input logic reset,        // Synchronous active-high reset
    output logic [2:0] ena,   // Enable signals for tens, hundreds, and thousands digits
    output logic [15:0] q     // 4-digit BCD counter output: q[3:0] - ones, q[7:4] - tens, q[11:8] - hundreds, q[15:12] - thousands
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0;
            ena <= 3'b0;
        end else begin
            ena <= 3'b0;
            if (q == 16'h9999) begin
                q <= 16'b0;
            end else begin
                // Increment ones digit
                if (q[3:0] == 4'd9) begin
                    q[3:0] <= 4'd0;
                    // Increment tens digit
                    if (q[7:4] == 4'd9) begin
                        q[7:4] <= 4'd0;
                        ena[0] <= 1'b1;
                        // Increment hundreds digit
                        if (q[11:8] == 4'd9) begin
                            q[11:8] <= 4'd0;
                            ena[1] <= 1'b1;
                            // Increment thousands digit
                            if (q[15:12] == 4'd9) begin
                                q[15:12] <= 4'd0;
                                ena[2] <= 1'b1;
                            end else begin
                                q[15:12] <= q[15:12] + 4'd1;
                            end
                        end else begin
                            q[11:8] <= q[11:8] + 4'd1;
                        end
                    end else begin
                        q[7:4] <= q[7:4] + 4'd1;
                    end
                end else begin
                    q[3:0] <= q[3:0] + 4'd1;
                end
            end
        end
    end

endmodule
[DONE]