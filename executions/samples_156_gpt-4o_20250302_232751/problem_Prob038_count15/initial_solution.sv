module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Internal register to hold the counter value
    logic [3:0] count;

    // Sequential logic for counter with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000; // Reset counter to 0
        end else begin
            if (count == 4'b1111) begin
                count <= 4'b0000; // Wrap around from 15 to 0
            end else begin
                count <= count + 1; // Increment counter
            end
        end
    end

    // Assign the internal count to the output
    assign q = count;

endmodule