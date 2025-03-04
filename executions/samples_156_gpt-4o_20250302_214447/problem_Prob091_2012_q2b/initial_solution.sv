module TopModule (
    input  logic [5:0] y,  // 6-bit one-hot encoded state input
    input  logic       w,  // 1-bit input for state transition condition
    input  logic       clk, // Clock signal
    input  logic       reset, // Synchronous reset
    output logic       Y1, // 1-bit output to be the input of flip-flop y[1]
    output logic       Y3  // 1-bit output to be the input of flip-flop y[3]
);

    // Next state logic
    always @(*) begin
        // Default assignments
        Y1 = 1'b0;
        Y3 = 1'b0;

        // State transitions
        case (y)
            6'b000001: begin // State A
                if (w) 
                    Y1 = 1'b1; // Transition to State B
            end
            6'b000010: begin // State B
                if (w)
                    Y3 = 1'b1; // Transition to State C
                else
                    Y3 = 1'b1; // Transition to State D
            end
            6'b000100: begin // State C
                if (w)
                    Y1 = 1'b1; // Transition to State E
                else
                    Y3 = 1'b1; // Transition to State D
            end
            6'b001000: begin // State D
                if (w)
                    Y3 = 1'b1; // Transition to State F
                else
                    Y1 = 1'b1; // Transition to State A
            end
            6'b010000: begin // State E
                if (!w)
                    Y3 = 1'b1; // Transition to State D
            end
            6'b100000: begin // State F
                if (w)
                    Y3 = 1'b1; // Transition to State C
                else
                    Y3 = 1'b1; // Transition to State D
            end
            default: begin
                // Handle invalid state (error state)
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            y <= 6'b000001; // Reset to State A
        end else begin
            // Update state based on next state logic
            y <= {Y1, Y3, 4'b0};
        end
    end

endmodule