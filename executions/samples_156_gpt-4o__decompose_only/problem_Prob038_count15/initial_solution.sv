module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    // Internal register to hold the current count value
    logic [3:0] count_reg;

    // Sequential logic for the counter with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            count_reg <= 4'b0000; // Reset the counter to 0
        end else begin
            count_reg <= count_reg + 1; // Increment the counter
        end
    end

    // Assign the current count value to the output port q
    assign q = count_reg;

endmodule