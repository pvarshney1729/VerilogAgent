[BEGIN]
module TopModule (
    input logic clk,          // Clock signal (Positive edge-triggered)
    input logic areset,      // Asynchronous active-high reset
    input logic x,           // Input signal (one bit, treated as signed)
    output logic z           // Output signal (one bit, treated as signed)
);

    // State Definitions for one-hot encoding
    parameter logic [1:0] state_A = 2'b01;
    parameter logic [1:0] state_B = 2'b10;

    logic [1:0] state; // State register for the FSM

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (areset) begin
            z <= 1'b0;            // Initialize output to 0 on reset
            state <= state_A;     // Move to State A on reset
        end else begin
            case (state)
                state_A: begin
                    if (x == 1'b0) begin
                        z <= 1'b0; // A --x=0 (z=0)--> A
                        state <= state_A;
                    end else begin
                        z <= 1'b1; // A --x=1 (z=1)--> B
                        state <= state_B;
                    end
                end
                state_B: begin
                    if (x == 1'b0) begin
                        z <= 1'b1; // B --x=0 (z=1)--> B
                        state <= state_B;
                    end else begin
                        z <= 1'b0; // B --x=1 (z=0)--> B
                        state <= state_B;
                    end
                end
            endcase
        end
    end
endmodule
[DONE]