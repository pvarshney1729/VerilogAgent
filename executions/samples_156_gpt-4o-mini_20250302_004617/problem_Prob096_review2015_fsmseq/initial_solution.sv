module fsm_sequence_detector (
    input logic clk,
    input logic reset,
    input logic data_in,
    output logic start_shifting
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (data_in) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (data_in) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (~data_in) next_state = S3;
                else next_state = S1;
            end
            S3: begin
                if (data_in) begin
                    next_state = S1; // Detecting '1' after '1101'
                    start_shifting = 1'b1; // Output high for one cycle
                end else begin
                    next_state = S0;
                    start_shifting = 1'b0; // Reset output
                end
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    assign start_shifting = (current_state == S3 && data_in);

endmodule