module TopModule(
    input logic clk,
    input logic reset,
    input logic slowena,
    output logic [3:0] q
);

    // Declare a register to hold the count value
    logic [3:0] count;

    // Sequential logic block triggered on the positive edge of the clock
    always_ff @(posedge clk) begin
        if (reset) begin
            // Synchronous reset: set count to 0
            count <= 4'b0000;
        end else if (slowena) begin
            // Increment the counter if slowena is high
            if (count == 4'b1001) begin
                // Wrap around to 0 if count reaches 9
                count <= 4'b0000;
            end else begin
                // Otherwise, increment the count
                count <= count + 1;
            end
        end
    end

    // Assign the count value to output q
    assign q = count;

endmodule