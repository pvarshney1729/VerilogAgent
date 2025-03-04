module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

    // Internal register to hold the count value
    logic [9:0] count;

    // Sequential logic for counter with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 10'b0000000000; // Reset count to 0
        end else if (count == 10'd999) begin
            count <= 10'b0000000000; // Wrap around to 0 after reaching 999
        end else begin
            count <= count + 1; // Increment count
        end
    end

    // Assign the internal count to the output
    assign q = count;

endmodule