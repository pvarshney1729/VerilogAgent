module TopModule (
    input logic [5:0] y,
    input logic w,
    input logic clk,
    input logic reset,
    output logic Y1,
    output logic Y3
);

    // Next state logic
    logic [5:0] next_y;

    always @(*) begin
        // Default next state is the current state
        next_y = y;
        
        case (y)
            6'b000001: begin // State A
                if (w) next_y = 6'b000010; // Transition to State B
            end
            6'b000010: begin // State B
                if (w) 
                    next_y = 6'b000100; // Transition to State C
                else 
                    next_y = 6'b001000; // Transition to State D
            end
            6'b000100: begin // State C
                if (w) 
                    next_y = 6'b010000; // Transition to State E
                else 
                    next_y = 6'b001000; // Transition to State D
            end
            6'b001000: begin // State D
                if (w) 
                    next_y = 6'b100000; // Transition to State F
                else 
                    next_y = 6'b000001; // Transition to State A
            end
            6'b010000: begin // State E
                if (!w) 
                    next_y = 6'b001000; // Transition to State D
            end
            6'b100000: begin // State F
                if (w) 
                    next_y = 6'b000100; // Transition to State C
                else 
                    next_y = 6'b001000; // Transition to State D
            end
            default: begin
                next_y = 6'b000001; // Default to State A
            end
        endcase
    end

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            next_y <= 6'b000001; // Reset to State A
        end else begin
            next_y <= next_y;
        end
    end

    // Output logic
    assign Y1 = (y == 6'b000001) && w; // Assert Y1 when transitioning to State B
    assign Y3 = ((y == 6'b000010) && !w) || ((y == 6'b000100) && !w) || ((y == 6'b100000) && !w); // Assert Y3 when transitioning to State D

endmodule