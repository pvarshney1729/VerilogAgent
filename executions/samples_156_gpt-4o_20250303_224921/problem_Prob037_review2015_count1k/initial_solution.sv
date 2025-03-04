module TopModule (
    input logic clk,        // 1 bit, positive edge-triggered clock signal
    input logic reset,      // 1 bit, active high synchronous reset signal
    output logic [9:0] q    // 10 bits, unsigned, with q[9] as MSB and q[0] as LSB
);

    // Internal register for the counter
    logic [9:0] counter;

    // Sequential logic for counter operation
    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 10'd0;  // Reset counter to 0
        end else begin
            if (counter == 10'd999) begin
                counter <= 10'd0;  // Wrap around to 0 after reaching 999
            end else begin
                counter <= counter + 10'd1;  // Increment counter
            end
        end
    end

    // Assign the internal counter to the output
    assign q = counter;

endmodule