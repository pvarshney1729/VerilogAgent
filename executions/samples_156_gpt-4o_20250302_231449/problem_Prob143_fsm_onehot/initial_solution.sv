```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    input logic [9:0] state,
    output logic [9:0] next_state,
    output logic out1,
    output logic out2
);

    // Default output values
    assign out1 = 1'b0;
    assign out2 = 1'b0;

    always_ff @(posedge clk) begin
        if (reset) begin
            next_state <= 10'b0000000001; // Reset to S0
        end else begin
            // Default next_state to all zeros
            next_state = 10'b0000000000;

            // Priority logic for state transition
            if (state[0]) begin
                next_state[1] = in ? 1'b1 : 1'b0; // S0 to S1 if in is high
                next_state[0] = ~in ? 1'b1 : 1'b0; // Remain in S0 if in is low
            end else if (state[1]) begin
                next_state[2] = in ? 1'b1 : 1'b0; // S1 to S2 if in is high
                next_state[1] = ~in ? 1'b1 : 1'b0; // Remain in S1 if in is low
            end else if (state[2]) begin
                next_state[3] = in ? 1'b1 : 1'b0; // S2 to S3 if in is high
                next_state[2] = ~in ? 1'b1 : 1'b0; // Remain in S2 if in is low
            end else if (state[3]) begin
                next_state[4] = in ? 1'b1 : 1'b0; // S3 to S4 if in is high
                next_state[3] = ~in ? 1'b1 : 1'b0; // Remain in S3 if in is low
            end else if (state[4]) begin
                next_state[5] = in ? 1'b1 : 1'b0; // S4 to S5 if in is high
                next_state[4] = ~in ? 1'b1 : 1'b0; // Remain in S4 if in is low
            end else if (state[5]) begin
                next_state[6] = in ? 1'b1 : 1'b0; // S5 to S6 if in is high
                next_state[5] = ~in ? 1'b1 : 1'b0; // Remain in S5 if in is low
            end else if (state[6]) begin
                next_state[7] = in ? 1'b1 : 1'b0; // S6 to S7 if in is high
                next_state[6] = ~in ? 1'b1 : 1'b0; // Remain in S6 if in is low
            end else if (state[7]) begin
                next_state[8] = in ? 1'b1 : 1'b0; // S7 to S8 if in is high
                next_state[7] = ~in ? 1'b1 : 1'b0; // Remain in S7 if in is low
            end else if (state[8]) begin
                next_state[9] = in ? 1'b1 : 1'b0; // S8 to S9 if in is high
                next_state[8] = ~in ? 1'b1 : 1'b0; // Remain in S8 if in is low
            end else if (state[9]) begin
                next_state[0] = in ? 1'b1 : 1'b0; // S9 to S0 if in is high
                next_state[9] = ~in ? 1'b1 : 1'b0; // Remain in S9 if in is low
            end else begin
                next_state[0] = 1'b1; // Default to S0 if invalid state
            end
        end
    end

endmodule
```