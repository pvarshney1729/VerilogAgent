module TopModule(
    input logic clk,        // Clock signal
    input logic reset,      // Active high synchronous reset
    output logic [3:0] q    // 4-bit output for the counter
);

    // Internal logic for the counter state
    logic [3:0] count;

    // Sequential logic block
    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 4'b0001; // Reset count to 1
        end else begin
            if (count == 4'b1010) begin
                count <= 4'b0001; // Wrap around to 1 after reaching 10
            end else begin
                count <= count + 1; // Increment the counter
            end
        end
    end

    // Assign the internal count to the output
    assign q = count;

endmodule