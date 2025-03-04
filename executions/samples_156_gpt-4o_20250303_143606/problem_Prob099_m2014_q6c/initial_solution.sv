module TopModule (
    input logic [5:0] y,      // State encoding input, 6 bits, one-hot encoded
    input logic       w,      // Transition condition input, 1 bit
    input logic       clk,    // Clock signal
    input logic       reset,  // Synchronous reset signal
    output logic      Y1,     // Output signal, 1 bit
    output logic      Y3,     // Output signal, 1 bit
    output logic      Y2,     // Next-state signal for state B, 1 bit
    output logic      Y4      // Next-state signal for state D, 1 bit
);

    logic [5:0] next_y;

    // Combinational logic for next state
    always @(*) begin
        next_y = 6'b000000; // Default to no state active
        case (y)
            6'b000001: begin // State A
                if (w == 0) next_y = 6'b000010; // Transition to B
                else next_y = 6'b000001; // Remain in A
            end
            6'b000010: begin // State B
                if (w == 0) next_y = 6'b000100; // Transition to C
                else next_y = 6'b001000; // Transition to D
            end
            6'b000100: begin // State C
                if (w == 0) next_y = 6'b010000; // Transition to E
                else next_y = 6'b001000; // Transition to D
            end
            6'b001000: begin // State D
                if (w == 0) next_y = 6'b100000; // Transition to F
                else next_y = 6'b000001; // Transition to A
            end
            6'b010000: begin // State E
                if (w == 0) next_y = 6'b010000; // Remain in E
                else next_y = 6'b001000; // Transition to D
            end
            6'b100000: begin // State F
                if (w == 0) next_y = 6'b000100; // Transition to C
                else next_y = 6'b001000; // Transition to D
            end
            default: next_y = 6'b000001; // Default to State A
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk) begin
        if (reset) begin
            y <= 6'b000001; // Initial state A
        end else begin
            y <= next_y;
        end
    end

    // Output logic
    always @(*) begin
        Y1 = 0; // Define based on specific logic
        Y3 = 0; // Define based on specific logic
        Y2 = next_y[1]; // Next-state signal for state B
        Y4 = next_y[3]; // Next-state signal for state D
    end

endmodule