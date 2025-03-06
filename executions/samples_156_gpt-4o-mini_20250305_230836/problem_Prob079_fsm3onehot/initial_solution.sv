module TopModule (
    input logic clk,               // Clock signal for synchronous operation
    input logic rst_n,             // Asynchronous active-low reset
    input logic in,                // 1-bit input signal for state transition
    input logic [3:0] state,       // 4-bit current state, one-hot encoded
    output logic [3:0] next_state, // 4-bit next state, one-hot encoded
    output logic out               // 1-bit output signal
);

    always @(*) begin
        // Default next state and output
        next_state = 4'b0000;
        out = 1'b0;

        case (state)
            4'b0001: begin // State A
                if (in) begin
                    next_state = 4'b0010; // Transition to State B
                end else begin
                    next_state = 4'b0001; // Remain in State A
                end
            end
            4'b0010: begin // State B
                if (in) begin
                    next_state = 4'b0010; // Remain in State B
                end else begin
                    next_state = 4'b0100; // Transition to State C
                end
            end
            4'b0100: begin // State C
                if (in) begin
                    next_state = 4'b1000; // Transition to State D
                end else begin
                    next_state = 4'b0001; // Transition to State A
                end
            end
            4'b1000: begin // State D
                out = 1'b1; // Output is 1 in State D
                if (in) begin
                    next_state = 4'b0010; // Transition to State B
                end else begin
                    next_state = 4'b0100; // Transition to State C
                end
            end
            default: begin
                next_state = 4'b0001; // Default to State A for illegal states
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            next_state <= 4'b0001; // Initialize to State A on reset
        end else begin
            next_state <= next_state; // Update state on clock edge
        end
    end

endmodule