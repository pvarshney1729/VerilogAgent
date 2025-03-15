module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    // State counter to track the number of cycles for which shift_ena is asserted
    logic [1:0] cycle_counter;

    // Sequential logic for state transitions and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            // On reset, initialize the counter and assert shift_ena
            cycle_counter <= 2'b00;
            shift_ena <= 1'b1;
        end else if (shift_ena) begin
            // If shift_ena is asserted, increment the counter
            if (cycle_counter < 2'b11) begin
                cycle_counter <= cycle_counter + 1;
            end else begin
                // Once the counter reaches 3, deassert shift_ena
                shift_ena <= 1'b0;
            end
        end
    end

endmodule