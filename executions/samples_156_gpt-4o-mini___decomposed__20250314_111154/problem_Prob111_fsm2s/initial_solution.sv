module TopModule (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);
    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) 
            current_state <= OFF;
        else 
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            OFF: begin
                out = 1'b0;
                if (j) 
                    next_state = ON;
                else 
                    next_state = OFF;
            end
            ON: begin
                out = 1'b1;
                if (k) 
                    next_state = OFF;
                else 
                    next_state = ON;
            end
            default: begin
                next_state = OFF; // Default case to handle any undefined state
            end
        endcase
    end
endmodule