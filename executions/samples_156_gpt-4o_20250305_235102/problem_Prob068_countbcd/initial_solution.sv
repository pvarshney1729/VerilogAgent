```verilog
[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    output logic [2:0] ena,
    output logic [15:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 16'b0000_0000_0000_0000;
            ena <= 3'b000;
        end else begin
            // Default ena signals to 0
            ena <= 3'b000;

            // Increment ones digit
            if (q[3:0] == 4'b1001) begin
                q[3:0] <= 4'b0000;
                ena[0] <= 1'b1; // Assert ena[0] when ones digit rolls over
            end else begin
                q[3:0] <= q[3:0] + 4'b0001;
            end

            // Increment tens digit if ena[0] is asserted
            if (ena[0]) begin
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0000;
                    ena[1] <= 1'b1; // Assert ena[1] when tens digit rolls over
                end else begin
                    q[7:4] <= q[7:4] + 4'b0001;
                end
            end

            // Increment hundreds digit if ena[1] is asserted
            if (ena[1]) begin
                if (q[11:8] == 4'b1001) begin
                    q[11:8] <= 4'b0000;
                    ena[2] <= 1'b1; // Assert ena[2] when hundreds digit rolls over
                end else begin
                    q[11:8] <= q[11:8] + 4'b0001;
                end
            end

            // Increment thousands digit if ena[2] is asserted
            if (ena[2]) begin
                if (q[15:12] == 4'b1001) begin
                    q[15:12] <= 4'b0000;
                end else begin
                    q[15:12] <= q[15:12] + 4'b0001;
                end
            end
        end
    end

endmodule
[DONE]
```