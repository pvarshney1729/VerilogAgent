module TopModule(
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Internal register to hold the current count
    logic [3:0] count;

    // Sequential logic for decade counter with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000; // Reset count to 0
        end else if (count == 4'b1001) begin
            count <= 4'b0000; // Wrap around to 0 after 9
        end else begin
            count <= count + 1; // Increment count
        end
    end

    // Assign the current count to the output
    assign q = count;

endmodule