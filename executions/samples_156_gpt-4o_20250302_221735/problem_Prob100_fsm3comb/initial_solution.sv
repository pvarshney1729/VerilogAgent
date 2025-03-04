module TopModule (
    input logic clk,           // Clock signal for sequential logic
    input logic rst_n,         // Active low asynchronous reset
    input logic in,            // 1-bit input signal
    input logic [1:0] state,   // 2-bit current state input
    output logic [1:0] next_state, // 2-bit next state output
    output logic out           // 1-bit output signal
);

    // Combinational logic for next state and output
    always @(*) begin
        case (state)
            2'b00: begin // State A
                if (in == 1'b0) 
                    next_state = 2'b00; // Remain in State A
                else 
                    next_state = 2'b01; // Transition to State B
                out = 1'b0;
            end
            2'b01: begin // State B
                if (in == 1'b0) 
                    next_state = 2'b10; // Transition to State C
                else 
                    next_state = 2'b01; // Remain in State B
                out = 1'b0;
            end
            2'b10: begin // State C
                if (in == 1'b0) 
                    next_state = 2'b00; // Transition to State A
                else 
                    next_state = 2'b11; // Transition to State D
                out = 1'b0;
            end
            2'b11: begin // State D
                if (in == 1'b0) 
                    next_state = 2'b10; // Transition to State C
                else 
                    next_state = 2'b01; // Transition to State B
                out = 1'b1;
            end
            default: begin
                next_state = 2'b00; // Default to State A
                out = 1'b0;
            end
        endcase
    end

endmodule