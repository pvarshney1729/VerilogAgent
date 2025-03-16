[BEGIN]
module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    initial state = 1'b0; // Initialize state to 0

    always_ff @(posedge clk) begin
        if (a && b) begin
            state <= ~state; // Toggle state if both a and b are 1
        end else if (b) begin
            state <= 1'b0;   // Set state to 0 if only b is 1
        end
    end

    assign q = state; // q follows the current state

endmodule
[END]