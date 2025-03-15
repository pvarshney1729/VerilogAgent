module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    // Internal register to keep track of the FSM state/count
    logic [2:0] counter; // 3 bits to count up to 4

    always_ff @(posedge clk) begin
        if (reset) begin
            // Upon reset, initialize the counter and enable signal
            counter <= 3'd0;
            shift_ena <= 1'b1;
        end else if (shift_ena) begin
            // If shift_ena is asserted, count up
            if (counter == 3'd3) begin
                // After 4 cycles, deassert shift_ena
                shift_ena <= 1'b0;
            end else begin
                // Increment the counter
                counter <= counter + 1;
            end
        end
    end

endmodule