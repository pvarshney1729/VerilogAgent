module TopModule(
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Internal register to hold the count value
    logic [3:0] count;

    // Sequential logic for the decade counter
    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 4'd0; // Reset the counter to 0
        end else if (count == 4'd9) begin
            count <= 4'd0; // Wrap around to 0 after reaching 9
        end else begin
            count <= count + 4'd1; // Increment the counter
        end
    end

    // Assign the internal count to the output
    assign q = count;

endmodule