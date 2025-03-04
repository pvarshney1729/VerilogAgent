module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3,
    output logic Y2,
    output logic Y4
);

    // Derive logic for Y2 and Y4 based on state transitions
    always @(*) begin
        // Default output values
        Y1 = 1'b0;
        Y3 = 1'b0;
        Y2 = 1'b0;
        Y4 = 1'b0;

        // Determine next-state conditions
        case (y)
            6'b000001: begin // State A
                Y2 = (w == 1'b0); // Transition to State B
            end
            6'b000010: begin // State B
                Y2 = (w == 1'b0); // Transition to State C
                Y4 = (w == 1'b1); // Transition to State D
            end
            6'b000100: begin // State C
                Y4 = 1'b1; // Transition to State D
            end
            6'b001000: begin // State D
                Y4 = (w == 1'b0); // Transition to State F
            end
            6'b010000: begin // State E
                Y4 = (w == 1'b1); // Transition to State D
            end
            6'b100000: begin // State F
                Y4 = 1'b1; // Transition to State D
            end
            default: begin
                // Handle undefined states
                Y1 = 1'b0;
                Y3 = 1'b0;
                Y2 = 1'b0;
                Y4 = 1'b0;
            end
        endcase
    end

endmodule