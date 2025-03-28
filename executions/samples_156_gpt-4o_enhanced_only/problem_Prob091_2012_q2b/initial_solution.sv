module TopModule(
    input logic [5:0] y,  // Current state encoded in one-hot
    input logic w,        // Input signal
    output logic Y1,      // Output for next state B
    output logic Y3       // Output for next state D
);

    always @(*) begin
        // Default outputs
        Y1 = 0;
        Y3 = 0;

        // Determine next state logic
        case (1'b1)  // One-hot encoding: check which state is active
            y[0]: begin  // State A
                Y1 = w;  // Transition to B on w = 1
            end
            y[1]: begin  // State B
                Y1 = 0;  // No direct transition back to B
                Y3 = ~w; // Transition to D on w = 0
            end
            y[2]: begin  // State C
                Y3 = ~w; // Transition to D on w = 0
            end
            y[3]: begin  // State D
                Y3 = ~w; // Stay in D on w = 0
            end
            y[4]: begin  // State E
                Y3 = ~w; // Transition to D on w = 0
            end
            y[5]: begin  // State F
                Y3 = ~w; // Transition to D on w = 0
            end
            default: begin
                // Handle unexpected state
                Y1 = 0;
                Y3 = 0;
            end
        endcase
    end

endmodule