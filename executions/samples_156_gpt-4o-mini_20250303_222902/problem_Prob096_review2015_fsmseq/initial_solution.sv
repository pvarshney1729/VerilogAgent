module TopModule (
    input  logic clk,         // Clock signal, positive edge triggered
    input  logic reset,       // Active high synchronous reset
    input  logic data,        // Input data stream, 1-bit
    output logic start_shifting // Output signal, 1-bit, initiates shift operation
);

    typedef enum logic [2:0] {
        IDLE      = 3'b000,
        S1        = 3'b001,
        S11       = 3'b010,
        S110      = 3'b011,
        DETECTED  = 3'b100
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (next_state == DETECTED) begin
                start_shifting <= 1'b1;
            end else if (current_state == DETECTED) begin
                start_shifting <= 1'b1; // Remain high until reset
            end else begin
                start_shifting <= 1'b0; // Clear on other states
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (data == 1'b1) next_state = S1;
                else next_state = IDLE;
            end
            S1: begin
                if (data == 1'b1) next_state = S11;
                else next_state = IDLE;
            end
            S11: begin
                if (data == 1'b0) next_state = S110;
                else next_state = IDLE;
            end
            S110: begin
                if (data == 1'b1) next_state = DETECTED;
                else next_state = IDLE;
            end
            DETECTED: begin
                next_state = DETECTED; // Remain in DETECTED state
            end
            default: next_state = IDLE; // Default case to handle unexpected states
        endcase
    end

endmodule