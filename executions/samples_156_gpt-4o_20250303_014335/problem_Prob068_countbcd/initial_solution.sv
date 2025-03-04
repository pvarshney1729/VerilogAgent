module TopModule (
    input  logic        clk,      // Clock signal, positive-edge triggered
    input  logic        reset,    // Synchronous active-high reset
    output logic [2:0]  ena,      // Enable signals for incrementing digits [1] to [3]
    output logic [15:0] q         // BCD Counter output, 4 digits
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 16'b0;
            ena <= 3'b0;
        end else begin
            // Default ena signals to 0
            ena <= 3'b0;

            // Increment ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                ena[1] <= 1'b1; // Enable tens digit increment
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
            end

            // Increment tens digit
            if (ena[1]) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    ena[2] <= 1'b1; // Enable hundreds digit increment
                end else begin
                    q[7:4] <= q[7:4] + 4'd1;
                end
            end

            // Increment hundreds digit
            if (ena[2]) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                    ena[3] <= 1'b1; // Enable thousands digit increment
                end else begin
                    q[11:8] <= q[11:8] + 4'd1;
                end
            end

            // Increment thousands digit
            if (ena[3]) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end else begin
                    q[15:12] <= q[15:12] + 4'd1;
                end
            end
        end
    end

endmodule