module TopModule(
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Internal register to hold the count value
    logic [3:0] count;

    // Sequential logic block triggered on the positive edge of the clock
    always_ff @(posedge clk) begin
        if (reset) begin
            // Synchronous reset: Set count to 0 when reset is high
            count <= 4'b0000;
        end else begin
            // Increment the count by one
            count <= count + 1;
        end
    end

    // Assign the internal count to the output
    assign q = count;

endmodule