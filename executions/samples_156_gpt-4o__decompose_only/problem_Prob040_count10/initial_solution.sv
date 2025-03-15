module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Internal register to hold the current count value
    logic [3:0] count;

    // Sequential logic for the decade counter
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000; // Reset the counter to 0
        end else if (count == 4'b1001) begin
            count <= 4'b0000; // Wrap around to 0 after reaching 9
        end else begin
            count <= count + 1; // Increment the counter
        end
    end

    // Assign the current count value to the output port q
    assign q = count;

endmodule