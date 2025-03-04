module TopModule (
    input  logic clk,      // Clock signal
    input  logic areset,   // Asynchronous reset signal
    input  logic in,       // Input signal for state transitions
    output logic out       // Output signal representing the current state's output value
);

    logic current_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 1'b1; // State B
        end else begin
            case (current_state)
                1'b0: current_state <= (in == 1'b0) ? 1'b1 : 1'b0; // State A transitions
                1'b1: current_state <= (in == 1'b0) ? 1'b0 : 1'b1; // State B transitions
            endcase
        end
    end

    always @(*) begin
        case (current_state)
            1'b0: out = 1'b0; // Output for state A
            1'b1: out = 1'b1; // Output for state B
        endcase
    end

endmodule