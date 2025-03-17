module TopModule(
    input logic clk,
    input logic reset,
    input logic slowena,
    output logic [3:0] q
);

    // Internal register to hold the count value
    logic [3:0] count;

    // Sequential logic for the decade counter
    always @(posedge clk) begin
        if (reset) begin
            // Synchronous reset: set count to 0
            count <= 4'b0000;
        end else if (slowena) begin
            // Increment the counter if slowena is high
            if (count == 4'b1001) begin
                count <= 4'b0000; // Wrap around to 0 after 9
            end else begin
                count <= count + 1;
            end
        end
    end

    // Assign the count value to the output q
    assign q = count;

endmodule