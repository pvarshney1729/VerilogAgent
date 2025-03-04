module TopModule (
    input logic clk,       // Clock signal
    input logic reset,     // Synchronous active-high reset
    output logic [2:0] ena, // Enable signals for upper three BCD digits
    output logic [15:0] q   // 4-digit BCD counter
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0000_0000_0000_0000;
            ena <= 3'b000;
        end else begin
            if (q[3:0] == 4'b1001) begin
                q[3:0] <= 4'b0000;
                ena[0] <= 1'b1;
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0000;
                    ena[1] <= 1'b1;
                    if (q[11:8] == 4'b1001) begin
                        q[11:8] <= 4'b0000;
                        ena[2] <= 1'b1;
                        if (q[15:12] == 4'b1001) begin
                            q[15:12] <= 4'b0000;
                        end else begin
                            q[15:12] <= q[15:12] + 1'b1;
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 1'b1;
                    end
                end else begin
                    q[7:4] <= q[7:4] + 1'b1;
                end
            end else begin
                q[3:0] <= q[3:0] + 1'b1;
                ena[0] <= 1'b0;
            end
            ena[1] <= 1'b0;
            ena[2] <= 1'b0;
        end
    end

endmodule