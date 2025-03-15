module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);
    // Internal signal to hold the counter value
    logic [9:0] counter;

    // Synchronous reset and counting logic
    always @(*) begin
        if (reset) begin
            counter = 10'b000000000; // Reset counter to 0
        end else begin
            if (counter < 10'd999) begin
                counter = counter + 10'b000000001; // Increment counter
            end else begin
                counter = 10'b000000000; // Roll over to 0 after 999
            end
        end
    end

    // Output the counter value
    assign q = counter;

    // Always block to update counter on clock edge
    always @(posedge clk) begin
        counter = counter; // Maintain current counter value
    end

endmodule