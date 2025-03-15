module TopModule (
    input [5:0] y,
    input w,
    output logic Y1,
    output logic Y3
);

    // State output logic for Y1 and Y3 based on the FSM and one-hot encoding
    always @(*) begin
        // Default assignments
        Y1 = 1'b0;
        Y3 = 1'b0;
        
        // Determine the next state logic for Y1 and Y3
        case (y)
            6'b000001: begin // State A
                if (w) 
                    Y1 = 1'b1; // Transition to B
            end
            6'b000010: begin // State B
                if (w) 
                    Y1 = 1'b0; // Transition to C
                else 
                    Y3 = 1'b1; // Transition to D
            end
            6'b000100: begin // State C
                if (w) 
                    Y3 = 1'b0; // Transition to E
                else 
                    Y3 = 1'b1; // Transition to D
            end
            6'b001000: begin // State D
                if (w) 
                    Y1 = 1'b0; // Transition to F
                else 
                    Y1 = 1'b0; // Transition to A
            end
            6'b010000: begin // State E
                if (w) 
                    Y3 = 1'b0; // Stay in E
                else 
                    Y3 = 1'b1; // Transition to D
            end
            6'b100000: begin // State F
                if (w) 
                    Y1 = 1'b0; // Transition to C
                else 
                    Y3 = 1'b1; // Transition to D
            end
            default: begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
        endcase
    end

endmodule